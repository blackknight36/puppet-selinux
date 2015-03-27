#!/bin/bash
#
# This file is managed by Puppet via the "<%= @module_name %>" module.

# Synopsis:
#       Create SSL Certificates for Koji infrastructure.
#
# Author:
#       John Florian <john_florian@dart.biz>

SELF="$(basename $0)"

# The (directory) name of our Certificate Authority for Koji infrastructure.
CA_NAME='<%= @ca_name %>'

# The Certificate Authority's own certificate and key files.
CA_CRT="certs/${CA_NAME}_ca_cert.crt"
CA_KEY="private/${CA_NAME}_ca_cert.key"

# The hostname providing home directories over NFS.
NFS_HOME='<%= @nfs_home %>'


fail() {
    if [ "$1" = '-h' ]
    then
        usage
        shift
    fi
    echo >&2 "Error: $*"
    exit 1
}

usage() {
    cat >&2 <<EOF
Usage:
$SELF [OPTION]... NAME

Options:
    -h
        Display this help and exit.

    -r
        Revoke a user's certificate instead of generating one.

    -s
        NAME identifies a service rather than user.  Effectively this means:
            1. Only the basic client certificate is needed.
            2. No web client certificate is needed.
            3. The created certificate will not be deployed automatically.  It
            is up to the system administrator to deploy the resultant files
            wherever they might be needed.

Examples:
    $SELF <%= @admin_user %>
    $SELF jflorian
    $SELF -s kojihub
    $SELF -s kojiweb

EOF
}

get_options_and_arguments() {
    local opt
    name_is_service='no'
    revoke='no'
    OPTIND=1
    while getopts ':hrs' opt
    do
        case "$opt" in
            h)  usage && exit 0 ;;
            r)  revoke='yes' ;;
            s)  name_is_service='yes' ;;
            \?) fail -h "invalid option: -$OPTARG" ;;
            \:) fail -h "option -$OPTARG requires an argument" ;;
        esac
    done
    shift $((OPTIND-1)); OPTIND=1
    [ $# -eq 1 ] || fail -h "you must specify the NAME argument"
    user="$1"
    user_cnf="confs/${user}-ssl.cnf"
    user_crt="certs/${user}.crt"
    user_csr="certs/${user}.csr"
    user_key="private/${user}.key"
    user_pem="certs/${user}.pem"
    user_web_crt="certs/${user}_browser_cert.p12"
}

notice() {
    echo -e "\n## $* ..."
}

create_client_cert() {
    notice 'Creating regular client certificate'
    openssl genrsa -out ${user_key} 2048
    sed 's/insert_hostname/'${user}'/' < ssl.cnf > ${user_cnf}
    openssl req -config ${user_cnf} -new -nodes -out ${user_csr} \
        -key ${user_key}
    openssl ca -config ${user_cnf} -keyfile ${CA_KEY} -cert ${CA_CRT} \
        -out ${user_crt} -outdir certs -infiles ${user_csr}
    cat ${user_crt} ${user_key} > ${user_pem}
}

create_webclient_cert() {
    notice 'Creating web client certificate'
    openssl pkcs12 -export -CAfile ${CA_CRT} \
        -inkey ${user_key} -in ${user_crt} -out ${user_web_crt}
}

deploy_certs() {
    # <%= @admin_user %>'s home assumed to be on local host; all others are on NFS.
    if [ $user = '<%= @admin_user %>' ]
    then
        target=~<%= @admin_user %>/.koji/
    else
        target="${user}@${NFS_HOME}:~/.koji/"
    fi

    notice  "Copying certificates to ${target}"
    local tmp=$(mktemp -d --suffix=".$SELF")
    local tmp2="${tmp}/.koji"
    mkdir ${tmp2}
    cp ${CA_CRT} ${tmp2}/clientca.crt
    cp ${CA_CRT} ${tmp2}/serverca.crt
    cp ${user_pem} ${tmp2}/client.crt
    cp ${user_web_crt} ${tmp2}/
    rsync -av ${tmp2}/ ${target}
    rm -rf ${tmp}

    cat <<EOF


Reminder:
    You must import ~/.koji/$(basename ${user_web_crt}) into your web
    browser(s) in order to be able to identify/authenticate yourself to the
    Koji web server.

EOF
}

revoke_client_cert() {
    notice 'Revoking client certificate'
    openssl ca -config ${user_cnf} -keyfile ${CA_KEY} -cert ${CA_CRT} \
        -revoke ${user_crt}
}

main() {
    get_options_and_arguments "$@"
    if [ $revoke = 'yes' ]
    then
        revoke_client_cert
    else
        create_client_cert
    fi
    if [ $name_is_service = 'no' ]
    then
        create_webclient_cert
        deploy_certs
    fi
}


main "$@"

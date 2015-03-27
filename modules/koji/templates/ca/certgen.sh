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
        Make a certificate for authenticating a Koji service named NAME to
        a Koji client.

    -S HOST
        Make a certificate for authenticating Koji service named NAME running
        on HOST as a client to the Koji Hub.

Examples:
    # Create a client certificate for the Koji administrator.
    $SELF <%= @admin_user %>

    # Create a client certificate for a regular user.
    $SELF jflorian

    # Create service certificates for Koji Hub and Koji Web.
    $SELF -s kojihub
    $SELF -s kojiweb

    # Create a client certificate for a Koji Builder running on
    # host.example.com.
    $SELF -S host.example.com  kojid

    # Create a client certificate for Kojira running on koji.example.com.
    $SELF -S koji.example.com  kojira

EOF
}

get_options_and_arguments() {
    local opt suffix
    host=''
    mode='user'
    revoke='no'
    OPTIND=1
    while getopts ':hrsS:' opt
    do
        case "$opt" in
            h)  usage && exit 0 ;;
            r)  revoke='yes' ;;
            s)  mode='service' ;;
            S)  mode='client'; host=$OPTARG ;;
            \?) fail -h "invalid option: -$OPTARG" ;;
            \:) fail -h "option -$OPTARG requires an argument" ;;
        esac
    done
    shift $((OPTIND-1)); OPTIND=1
    [ $# -eq 1 ] || fail -h "you must specify the NAME argument"
    user="$1"
    [[ -n "$host" ]] && suffix="-on-${host}" || suffix=''
    user_cnf="confs/${user}${suffix}-ssl.cnf"
    user_crt="certs/${user}${suffix}.crt"
    user_csr="certs/${user}${suffix}.csr"
    user_key="private/${user}${suffix}.key"
    user_pem="certs/${user}${suffix}.pem"
    user_web_crt="certs/${user}${suffix}_browser_cert.p12"
}

notice() {
    echo -e "\n## $* ..."
}

create_client_cert() {
    local default_cn default_ou
    notice 'Creating regular client certificate'
    openssl genrsa -out ${user_key} 2048
    case $mode in
        user)
            default_cn="${user}"
            default_ou='Koji Users'
            ;;
        service)
            default_cn="$(hostname -f)"
            default_ou="${user}"
            ;;
        client)
            default_cn="${user}"
            default_ou="${host}"
            ;;
    esac
    sed "s/@@DEFAULT_CN@@/${default_cn}/;s/@@DEFAULT_OU@@/${default_ou}/" \
            < ssl.cnf > ${user_cnf}
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
    if [ $mode = 'user' ]
    then
        create_webclient_cert
        deploy_certs
    fi
}


main "$@"

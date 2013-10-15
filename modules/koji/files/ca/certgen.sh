#!/bin/bash

# Create SSL Certificates for Koji infrastructure.
#
# Author: John Florian <john_florian@dart.biz>

SELF="$(basename $0)"

# The (directory) name of our Certificate Authority for Koji infrastructure.
CA_NAME='koji'

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

    -s
        NAME identifies a service rather than user.  Effectively this means:
            1. Only the basic client certificate is needed.
            2. No web client certificate is needed.
            3. The created certificate will not be deployed automatically.  It
            is up to the system administrator to deploy the resultant files
            wherever they might be needed.

Examples:
    $SELF kojiadmin
    $SELF d13677
    $SELF -s kojihub
    $SELF -s kojiweb

EOF
}

get_options_and_arguments() {
    local opt
    name_is_service='no'
    OPTIND=1
    while getopts ':hs' opt
    do
        case "$opt" in
            h)  usage && exit 0 ;;
            s)  name_is_service='yes' ;;
            \?) fail -h "invalid option: -$OPTARG" ;;
            \:) fail -h "option -$OPTARG requires an argument" ;;
        esac
    done
    shift $((OPTIND-1)); OPTIND=1
    [ $# -eq 1 ] || fail -h "you must specify the NAME argument"
    user="$1"
}

create_client_cert() {
    echo -e '\n## Creating regular client certificate ...'
    openssl genrsa -out private/${user}.key 2048
    cat ssl.cnf | sed 's/insert_hostname/'${user}'/'> ssl2.cnf
    openssl req -config ssl2.cnf -new -nodes -out certs/${user}.csr \
        -key private/${user}.key
    openssl ca -config ssl2.cnf -keyfile private/${CA_NAME}_ca_cert.key \
        -cert ${CA_NAME}_ca_cert.crt -out certs/${user}.crt -outdir certs \
        -infiles certs/${user}.csr
    cat certs/${user}.crt private/${user}.key > ${user}.pem
    mv ssl2.cnf confs/${user}-ssl.cnf
}

create_webclient_cert() {
    echo -e '\n## Creating web client certificate ...'
    openssl pkcs12 -export -inkey private/${user}.key -in certs/${user}.crt \
        -CAfile ${CA_NAME}_ca_cert.crt -out certs/${user}_browser_cert.p12
}

deploy_certs() {
    if [ $user = 'kojiadmin' ]
    then
        target=~kojiadmin/.koji/
    else
        target="${user}@mdct-00fs:~/.koji/"
    fi

    echo -e "\n## Copying certificates to ${target} ..."
    tmp=$(mktemp -d --suffix=".$SELF")
    tmp2="${tmp}/.koji"
    mkdir ${tmp2}
    cp ${user}.pem ${tmp2}/client.crt
    cp koji_ca_cert.crt ${tmp2}/clientca.crt
    cp koji_ca_cert.crt ${tmp2}/serverca.crt
    cp certs/${user}_browser_cert.p12 ${tmp2}/
    rsync -av ${tmp2}/ ${target}
    rm -rf ${tmp}

    cat <<EOF


Reminder:
    You must import ~/.koji/${user}_browser_cert.p12 into your web browser(s)
    in order to be able to identify/authenticate yourself to the Koji web
    server.

EOF
}

main() {
    get_options_and_arguments "$@"
    create_client_cert
    if [ $name_is_service = 'no' ]
    then
        create_webclient_cert
        deploy_certs
    fi
}


main "$@"

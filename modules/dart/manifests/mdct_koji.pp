# modules/dart/manifests/mdct_koji.pp
#
# Synopsis:
#       Koji Server for RPM Package Building
#
# See Also:
#
#       - https://fedoraproject.org/wiki/Koji/ServerHowTo
#
#       - /etc/pki/Koji
#
#           This directory contains an OpenSSL CA and one or more certificates
#           that koji uses to authenticate its various components: koji-hub,
#           koijid, koji-web, koji-client and kojira.  It also contains a
#           shell script to help create those certificates.  Most of the
#           intial CA setup is handled by koji::ca.  The administrator will
#           need to create a certificates though, using the shell script found
#           here.
#
#       - ~kojiadmin
#
#           This home directory (and its local owner/group accounts) is
#           populated with, at least:
#               - (renamed) copies of certificate files in ~kojiadmin/.koji
#
#       - ~koji
#
#       - postgresql database
#
#           Database creation and schema importation were peformed manually.
#
# Contact:
#       John Florian


class dart::mdct_koji inherits dart::abstract::guarded_server_node {

    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
    }

    include 'autofs'

    mailalias { 'root':
        ensure      => present,
        recipient   => 'john.florian@dart.biz',
    }

    $topdir     = '/srv/koji'
    $hub        = "http://${fqdn}/kojihub"
    $downloads  = "http://${fqdn}/kojifiles"

    class { 'koji::builder':
        client_cert => 'puppet:///private-host/mdct-koji.dartcontainer.com.pem',
        ca_cert     => 'puppet:///private-host/Koji_ca_cert.crt',
        web_ca_cert => 'puppet:///private-host/Koji_ca_cert.crt',
        hub         => "${hub}",
        downloads   => "${downloads}",
        top_dir     => "${topdir}",
    }

    class { 'koji::ca':
        country         => 'US',
        state           => 'Michigan',
        locality        => 'Mason',
        organization    => 'Dart Container Corp.',
    }

    class { 'koji::cli':
        hub         => "${hub}",
        web         => "http://${fqdn}/koji",
        downloads   => "${downloads}",
        top_dir     => "${topdir}",
    }

    class { 'koji::database':
        config_source  => 'puppet:///private-host/postgresql/postgresql.conf',
    }

    class { 'koji::hub':
        db_host     => 'localhost',
        db_user     => 'koji',
        db_passwd   => 'mdct.koji',
        web_cn      => "CN=${fqdn},OU=kojiweb,O=Dart Container Corp.,ST=Michigan,C=US",
        top_dir     => "${topdir}",
    }

    class { 'koji::kojira':
        hub     => "${hub}",
        top_dir => "${topdir}",
    }

    class { 'koji::web':
        secret  => 'D0gG0n31t',
    }

}

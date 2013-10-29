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

    $topdir     = '/mnt/koji'
    $hub        = "http://${fqdn}/kojihub"
    $downloads  = "http://${fqdn}/kojifiles"
    $repodir    = '/mnt/mdct-new-repo'

    class { 'dart::subsys::autofs::common':
        legacy  => false,
    }

    autofs::map_entry {

        "${topdir}":
            mount   => '/mnt',
            key     => 'koji',
            options => '-rw,hard,nosuid,noatime,fsc',
            remote  => 'mdct-00fs:/storage/projects/koji';

        "${repodir}":
            mount   => '/mnt',
            key     => 'mdct-new-repo',
            options => '-rw,hard,nosuid,noatime,fsc',
            remote  => 'mdct-00fs:/storage/projects/mdct-new-repo';

    }

    mailalias { 'root':
        ensure      => present,
        recipient   => 'john.florian@dart.biz',
    }

    class { 'koji::builder':
        client_cert => 'puppet:///private-host/mdct-koji.dartcontainer.com.pem',
        ca_cert     => 'puppet:///private-host/Koji_ca_cert.crt',
        web_ca_cert => 'puppet:///private-host/Koji_ca_cert.crt',
        hub         => "${hub}",
        downloads   => "${downloads}",
        top_dir     => "${topdir}",
        require     => [
            Autofs::Map_entry["${topdir}"],
            Class['Koji::Hub'],
        ],
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
        require     => Autofs::Map_entry["${topdir}"],
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
        require     => [
            Autofs::Map_entry["${topdir}"],
            Class['Koji::Database'],
        ],
    }

    class { 'koji::kojira':
        hub     => "${hub}",
        top_dir => "${topdir}",
        require     => [
            Autofs::Map_entry["${topdir}"],
            Class['Koji::Hub'],
        ],
    }

    class { 'koji::web':
        secret  => 'D0gG0n31t',
    }

    class { 'koji::mash':
        hub     => "${hub}",
        top_dir => "${topdir}",
        require     => [
            Autofs::Map_entry["${topdir}"],
            Class['Koji::Hub'],
        ],
    }

    koji::mash_repo { '19':
        source  => 'puppet:///private-host/mash/19.mash',
        require     => [
            Autofs::Map_entry["${repodir}"],
            Autofs::Map_entry["${topdir}"],
        ],
    }

}

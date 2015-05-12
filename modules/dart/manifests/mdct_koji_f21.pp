# modules/dart/manifests/mdct_koji_f21.pp
#
# == Class: dart::mdct_koji_f21
#
# Manages a Dart host as a Koji server.
#
# The host will be managed to provide:
#
#   - A dedicated SSL Certificate Authority (CA) for X509 certificates
#
#       /etc/pki/Koji/ contains an OpenSSL CA and one or more certificates
#       that Koji uses to authenticate its various components: koji-hub,
#       koijid, koji-web, koji-client and kojira.  It also contains a shell
#       script to create/revoke those certificates as well as additional
#       certificates for general user authentication.  Most of the initial CA
#       setup is handled by koji::ca.
#
#       Some services (e.g., httpd) will fail to start until certificates for
#       the following have been created:
#
#           - Koji-Web
#           - Koji-Hub
#           - Kojira
#
#       You will also want to create a user certificate for the Koji
#       administrator and most likely yourself too.
#
#   - Koji administrator account
#
#       The local user "kojiadmin" will be created.  This user's home
#       directory is populated with, at least:
#           - (renamed) copies of certificate files in ~kojiadmin/.koji
#
#   - PostgreSQL database
#
#       Initial database creation, schema importation and Koji administrator
#       account are performed automatically.  See Class[koji::database] for
#       details regarding upgrade procedures.
#
#   - Koji-Hub
#
#       Koji-Hub is the center of all Koji operations.  It is an XML-RPC
#       server running under mod_wsgi in the Apache httpd.  Koji-Hub is
#       passive in that it only receives XML-RPC calls and relies upon the
#       build daemons (kojid) and other components to initiate communication.
#       Koji-Hub is the only component that has direct access to the
#       PostgreSQL database and is one of the two components that have write
#       access to the file system.
#
#   - Koji CLI
#
#       The Koji command-line interface is the standard client.  It can
#       perform most tasks and is essential to the successful use of any Koji
#       environment.
#
#   - Koji-Web
#
#       A web interface for the masses, this is a set of scripts that run in
#       mod_wsgi and use the Cheetah templating engine to provide a web
#       interface to Koji.  Koji-Web exposes a lot of information and also
#       provides a means for certain operations, such as cancelling builds.
#
#   - Kojira
#
#       This daemon handles Yum repository creation and maintenance.
#
# Once you've successully gotten Puppet to build your Koji server, you will
# need to continue by bootstrapping the Koji build environment as discussed
# here:
#       https://fedoraproject.org/wiki/Koji/ServerBootstrap
#
# === See Also
#
#   The entire "koji" Puppet module upon which this class so heavily depends
#   is built in accordance with the documentation available at:
#
#       - https://fedoraproject.org/wiki/Koji/ServerHowTo
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_koji_f21 inherits ::dart::subsys::koji::params {

    class { '::network':
        service      => 'nm',
        domain       => $dart::params::dns_domain,
        name_servers => $dart::params::dns_servers,
    }

    network::interface { 'eth0':
        template   => 'static',
        ip_address => '10.1.192.124',
        netmask    => '255.255.0.0',
        gateway    => '10.1.0.25',
        stp        => 'no',
    }

    class { '::bacula::client':
        dir_name   => $dart::params::bacula_dir_name,
        dir_passwd => 'pSKBn8yre7g7nLjDAxSlPZpky5X13hWMgdQeEzftjim9',
        mon_name   => $dart::params::bacula_mon_name,
        mon_passwd => 'gn4IS28lZIXMWDzcHDJYpR0Ugj1mFuHKi08GiEAB0o66',
    }

    include '::dart::abstract::guarded_server_node'
    include '::dart::subsys::koji::authentication'
    include '::dart::subsys::koji::autofs'
    include '::dart::subsys::koji::cli'
    include '::dart::subsys::koji::database'
    include '::dart::subsys::koji::hub'
    include '::dart::subsys::koji::kojira'
    include '::dart::subsys::koji::mash'
    include '::dart::subsys::koji::web'

    ::sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

}

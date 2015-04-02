# modules/dart/manifests/mdct_koji_b1_f21.pp
#
# == Class: dart::mdct_koji_b1_f21
#
# Manages a Dart's mdct-koji-b1-f21 as Koji RPM package builder #1.
#
# Be sure to do the following prior to starting kojid (the builder daemon):
#
#       ssh koji
#       sudo -iu kojiadmin koji add-host kojibuilder1.example.com i386 x86_64
#
# If you fail to do so you'll need to manually remove entries from the
# sessions and users table before it can be run successfully.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === TODO
#   - Most of this should be refactored into a new
#   Define[dart::abstract::subsys::builder]
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_koji_b1_f21 {

    class { '::network':
        service      => 'nm',
        domain       => $dart::params::dns_domain,
        name_servers => $dart::params::dns_servers,
    }

    network::interface { 'eth0':
        template   => 'static',
        ip_address => '10.1.192.135',
        netmask    => '255.255.0.0',
        gateway    => '10.1.0.25',
        stp        => 'no',
    }

    include '::dart::abstract::guarded_server_node'
    include '::dart::subsys::koji::autofs'
    include '::dart::subsys::koji::params'

    ::sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

    class { '::mock::common':
    } ->

    mount { '/var/lib/mock':
        ensure  => 'mounted',
        atboot  => true,
        device  => '/dev/disk/by-uuid/554aaf54-ccda-44b2-81fa-9c1990000758',
        fstype  => 'auto',
        options => 'defaults',
    } ->

    class { '::koji::builder':
        client_cert => "puppet:///modules/dart/koji/kojid-on-${::fqdn}.pem",
        ca_cert     => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        web_ca_cert => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        hub         => $::dart::subsys::koji::params::hub,
        downloads   => $::dart::subsys::koji::params::downloads,
        top_dir     => $::dart::subsys::koji::params::topdir,
        work_dir    => $::dart::subsys::koji::params::workdir,
        require     => Class['::dart::subsys::koji::autofs'],
        debug       => $::dart::subsys::koji::params::debug,
    }

}

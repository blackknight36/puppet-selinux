# modules/dart/manifests/mdct_koji_b2_f21.pp
#
# == Class: dart::mdct_koji_b2_f21
#
# Manages a Dart's mdct-koji-b2-f21 as Koji RPM package builder #1.
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
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_koji_b2_f21 {

    class { '::network':
        service      => 'nm',
        domain       => $dart::params::dns_domain,
        name_servers => $dart::params::dns_servers,
    }

    network::interface { 'eth0':
        template   => 'static',
        ip_address => '10.201.64.35',
        netmask    => '255.255.252.0',
        gateway    => '10.201.67.254',
        stp        => 'no',
    }

    class { '::dart::abstract::koji_builder_node':
        mock_disk_uuid => 'f64e545f-06fa-4ca5-ae70-ef361edfb5cf',
    }

}

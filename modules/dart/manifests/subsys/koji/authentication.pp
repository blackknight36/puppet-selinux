# modules/dart/manifests/subsys/koji/authentication.pp
#
# == Class: dart::subsys::koji::authentication
#
# Manages the Koji authentication.
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


class dart::subsys::koji::authentication inherits ::dart::subsys::koji::params {

    file { $::dart::subsys::koji::params::local_homes:
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'home_root_t',
    } ->

    user { 'kojiadmin':
        comment    => 'Koji Administrator',
        uid        => 1000,
        home       => "${::dart::subsys::koji::params::local_homes}/kojiadmin",
        managehome => true,
    } ->

    user { 'koji':
        comment    => 'Koji User',
        uid        => 1001,
        home       => "${::dart::subsys::koji::params::local_homes}/koji",
        managehome => true,
    }

    class { '::koji::ca':
        country      => 'US',
        state        => 'Michigan',
        locality     => 'Mason',
        organization => 'Dart Container Corp.',
        nfs_home     => 'mdct-00fs',
    }

}

# modules/firewall_driven/manifests/master.pp
#
# == Class: firewall_driven::master
#
# Configures a host to run the firewall-driven-master package and to serve
# hosts running the firewall-driven-slave package.
#
# === Parameters
#
# [*ensure*]
#   What state should the package be in?  One of: "present" (the default, also
#   called "installed"), "absent", "latest" or some specific version.
#
# [*content*]
#   Literal content for the master configuration file.  One and only one of
#   "content" or "source" must be given.
#
# [*source*]
#   URI of the master configuration file content.  One and only one of
#   "content" or "source" must be given.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class firewall_driven::master (
        $ensure='present',
        $content=undef,
        $source=undef,
    ) {

    include 'firewall_driven::master::params'

    package { $firewall_driven::master::params::packages:
        ensure  => $ensure,
    }

    firewall_driven::master::config { 'firewall-driven':
        content => $content,
        source  => $source,
    }

}

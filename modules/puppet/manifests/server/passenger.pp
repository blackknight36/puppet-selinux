# modules/puppet/manifests/server/passenger.pp
#
# == Class: puppet::server::passenger
#
# Configures a puppet master to serve via Phusion Passenger via Apache httpd.
#
# === Parameters
#
# NONE
#
# === See Also
#
# http://docs.puppetlabs.com/guides/passenger.html
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class puppet::server::passenger {

    class { 'apache':
        network_connect => true,
    }

    include 'apache::mod_passenger'
    include 'apache::mod_ssl'
    include 'puppet::params'

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'usr_t',
        before      => Service[$apache::params::services],
        notify      => Service[$apache::params::services],
        subscribe   => Package[$puppet::params::server_packages],
    }

    file {
        '/usr/share/puppet/rack/':
            ensure  => directory;

        '/usr/share/puppet/rack/puppetmasterd/':
            ensure  => directory;

        '/usr/share/puppet/rack/puppetmasterd/public/':
            ensure  => directory;

        '/usr/share/puppet/rack/puppetmasterd/tmp/':
            ensure  => directory,
            owner   => 'puppet',
            group   => 'apache',
            mode    => '0775';

        '/usr/share/puppet/rack/puppetmasterd/config.ru':
            owner   => 'puppet',
            group   => 'puppet',
            source  => 'puppet:///modules/puppet/config.ru';
    }

    apache::site_config { 'puppetmaster':
        content => template('puppet/puppetmaster.conf'),
    }

}

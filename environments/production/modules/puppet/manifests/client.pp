# modules/puppet/manifests/client.pp
#
# == Class: puppet::client
#
# Configures a host as a puppet client.
#
# === Parameters
#
# [*enable*]
#   If true (default), the puppet client service will be enabled for automatic
#   startup during system boot.  Otherwise the client service will not be
#   started automatically.
#
# [*ensure*]
#   If 'running' (default), the puppet client service will be started
#   immediately, if it is not already running.  Other valid values are:
#   'stopped', false (same as 'stopped') and true (same as 'running').
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   John Florian <john.florian@dart.biz>
#   Michael Watters <michael.watters@dart.biz>


class puppet::client ($enable=true, $ensure='running') {

    include 'puppet::params'

    $sorry = "$fqdn is running puppet-$puppetversion atop $operatingsystem $operatingsystemrelease.  Versions prior to 2.6 can no longer be supported.  Please upgrade or disable puppet there!"

    $scary = "$fqdn is running puppet-$puppetversion atop $operatingsystem $operatingsystemrelease.  Versions 2.6.6 and prior are poorly supported and quite buggy.  Please upgrade!"

    if versioncmp($puppetversion, '2.6') < 0 {
        $era = 'ge-0.0-lt-2.6'
        fail ("$sorry")
    } else {
        if versioncmp($puppetversion, '2.6.6') <= 0 {
            $era = 'ge-2.6-le-2.6.6'
            warning "$scary"
        } else {
            $era = 'gt-2.6.6'
        }
    }

    package { $puppet::params::client_packages:
        ensure  => installed,
        notify  => Service[$puppet::params::client_services],
    }

    File {
        owner       => 'root',
        group       => 'puppet',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'puppet_etc_t',
        before      => Service[$puppet::params::client_services],
        notify      => Service[$puppet::params::client_services],
        subscribe   => Package[$puppet::params::client_packages],
    }

    if $puppet::params::is_puppet_master == true {
        file { "${puppet::params::puppet_conf_dir}/puppet.conf":
            ensure  => file,
            source  => 'puppet:///private-host/puppet/puppet.conf',
        }
    }

    if $::operatingsystem == 'CentOS' {
        file { "${puppet::params::puppet_conf_dir}/puppet.conf":
            ensure  => file,
            content => template('puppet/puppet.conf.centos7'),
        }
    }

    else {
        file { "${puppet::params::puppet_conf_dir}/puppet.conf":
            ensure  => file,
            content => template("puppet/puppet.conf.${era}.erb"),
        }
    }

    service { $puppet::params::client_services:
        enable      => $enable,
        ensure      => $ensure,
        hasrestart  => true,
        hasstatus   => true,
    }

}

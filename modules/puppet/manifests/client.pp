# modules/puppet/manifests/client.pp

class puppet::client ($enable=true, $ensure='running') {

    include 'puppet::params'

    $scary = "$fqdn is running puppet-$puppetversion atop $operatingsystem $operatingsystemrelease.  Versions 2.6.6 and prior are poorly supported and quite buggy.  Please upgrade!"

    if versioncmp($puppetversion, '2.6') < 0 {
        $era = 'ge-0.0-lt-2.6'
        warning "$scary"
    } else {
        if versioncmp($puppetversion, '2.6.6') <= 0 {
            $era = 'ge-2.6-le-2.6.6'
            warning "$scary"
        } else {
            if versioncmp($puppetversion, '3.3') < 0 {
                $era = 'gt-2.6.6-lt-3.3'
            } else {
                $era = 'ge-3.3'
            }
        }
    }

    package { $puppet::params::client_packages:
        ensure  => installed,
        notify  => Service[$puppet::params::client_service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'puppet_etc_t',
        before      => Service[$puppet::params::client_service_name],
        notify      => Service[$puppet::params::client_service_name],
        subscribe   => Package[$puppet::params::client_packages],
    }

    file { '/etc/puppet/puppet.conf':
        source  => [
            'puppet:///private-host/puppet/puppet.conf',
            "puppet:///modules/puppet/puppet.conf.${era}",
        ],
    }

    service { $puppet::params::client_service_name:
        enable      => $enable,
        ensure      => $ensure,
        hasrestart  => true,
        hasstatus   => true,
    }

}

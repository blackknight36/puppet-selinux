# modules/autofs/manifests/mount2.pp
#
# Synopsis:
#       Installs automount configuration files for autofs.
#
# Description:
#       This obsoletes autofs::mount which should be avoided for new code.
#       This definition drops configuration files into /etc/auto.master.d/
#       which is more versatile than using /etc/auto.$name.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
#       master_source           URI of master map file content
#
#       map_source              URI of automount map file content
#
# Notes:
#
#       1. Default is 'present'.


define autofs::mount2 ($ensure='present', $master_source, $map_source) {

    include 'autofs::params'

    File {
        ensure      => $ensure,
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'bin_t',
        before      => Service[$autofs::params::service_name],
        notify      => Service[$autofs::params::service_name],
        subscribe   => Package[$autofs::params::packages],
    }

    file { "/etc/auto.master.d/${name}.autofs":
        source  => $master_source,
    }

    file { "/etc/auto.master.d/${name}.map":
        source  => $map_source,
    }

}

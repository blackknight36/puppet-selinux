# modules/autofs/manifests/mount.pp
#
# Synopsis:
#       Installs a automount configuration file for autofs.
#
# Description:
#       THIS DEFINITION IS OBSOLETE.  All new code should be using
#       autofs::mount_point (and autofs::map_entry) instead!
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
#       source                  URI of automount file content
#
# Notes:
#
#       1. Default is 'present'.


define autofs::mount ($ensure='present', $source) {

    include autofs::params

    file { "/etc/auto.${name}":
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
        source      => $source,
    }

}

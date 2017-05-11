# modules/selinux/manifests/init.pp
#
# Synopsis:
#       Configures SELinux on a host.
#
# Parameters:
#
# [*packages*]
#   List of packages to install.
#
# [*mode*]
#   One of: 'enforcing', 'permissive', or 'disabled'.
#   Default value is 'enforcing'.
#
# Requires:
#       NONE
#
# Usage Notes:
#
#       - Switching mode from enforcing or permissive to disabled requires
#       reboot.
#
#       - Switching mode from disabled to enforcing or permissive requires
#       reboot.

class selinux (
    Array[String] $packages = [
        'libselinux',
        'libselinux-utils',
        'policycoreutils-python',
        'selinux-policy',
        'selinux-policy-devel',     # provides audit2why
        'selinux-policy-targeted',
        ],
    Enum['enforcing', 'permissive', 'disabled'] $mode = 'enforcing',
    ) {

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'selinux_config_t',
        subscribe   => Package[$packages],
    }

    package { $packages:
        ensure => installed,
    }

    file { '/etc/selinux/config':
        content => template('selinux/config.erb'),
    }

    if $mode == 'enforcing' and $::selinux_simple == false {
        exec { '/usr/sbin/setenforce 1': }
    }

    if $mode == 'permissive' and $::selinux_simple == true {
        exec { '/usr/sbin/setenforce 0': }
    }

}

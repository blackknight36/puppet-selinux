# modules/selinux/manifests/init.pp
#
# Synopsis:
#       Configures SELinux on a host.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       mode            1       One of: 'enforcing', 'permissive', or
#                               'disabled'.
#
# Notes:
#
#       1. Default is 'enforcing'.
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


class selinux ($mode='enforcing') {

    include 'selinux::params'

    package { $selinux::params::packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'selinux_config_t',
        subscribe   => Package[$selinux::params::packages],
    }

    file { '/etc/selinux/config':
        content => template('selinux/config.erb'),
    }

}

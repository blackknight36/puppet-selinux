# modules/selinux/manifests/init.pp
#
# Synopsis:
#       Configures a host for SELinux.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE
#
# Usage Notes:
# 	-Switching mode from enforcing or permissive to disabled requires reboot.
# 	-Switching mode from disabled to enforcing or permissive requires reboot.
#
# Example Usage:
#
#       include selinux


class selinux ($mode='enforcing') {

    package { [
        'libselinux',
        'libselinux-utils',
        'policycoreutils-python',
        'selinux-policy',
        'selinux-policy-targeted',
        ]:
	ensure	=> installed,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'selinux_config_t',
    }

    file { '/etc/selinux/config':
        content => template('selinux/config.erb'),
    }

}

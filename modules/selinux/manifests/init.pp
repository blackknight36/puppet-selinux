# modules/selinux/manifests/selinux.pp
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
# Example usage:
#
#       include selinux

class selinux {

    package { [
        'libselinux',
        'libselinux-utils',
        'policycoreutils-python',
        'selinux-policy',
        'selinux-policy-targeted',
        ]:
	ensure	=> installed,
    }

}

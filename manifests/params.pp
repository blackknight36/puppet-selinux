# modules/selinux/manifests/params.pp
#
# Synopsis:
#       Parameters for the selinux puppet module.


class selinux::params {

    case $::operatingsystem {
        'Fedora': {

            if $::operatingsystemrelease < '18' {
                $packages = [
                    'libselinux',
                    'libselinux-utils',
                    'policycoreutils-python',   # provides audit2why
                    'selinux-policy',
                    'selinux-policy-targeted',
                ]
            } else {
                $packages = [
                    'libselinux',
                    'libselinux-utils',
                    'policycoreutils-python',
                    'selinux-policy',
                    'selinux-policy-devel',     # provides audit2why
                    'selinux-policy-targeted',
                ]
            }

        }

        'CentOS': {

            $packages = [
                'libselinux',
                'libselinux-utils',
                'selinux-policy',
                'selinux-policy-devel',     # provides audit2why
                'selinux-policy-targeted',
                ]
        }

        default: {
            fail ("The selinux module is not yet supported on ${operatingsystem}.")
        }

    }

}

# modules/selinux/manifests/params.pp
#
# Synopsis:
#       Parameters for the selinux puppet module.


class selinux::params {

    case $::operatingsystem {
        Fedora: {

            if $::operatingsystemrelease < 18 {
                $packages = [
                    'libselinux',
                    'libselinux-utils',
                    'policycoreutils-python',   # provides audit2why
                    'selinux-policy',
                    'selinux-policy-targeted',
                ]
<<<<<<< HEAD
            } else {
=======
            else {
>>>>>>> 980f23fc33ef1f127fd982dd5595cf4c794416f9
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

        default: {
            fail ("The selinux module is not yet supported on ${operatingsystem}.")
        }

    }

}

# modules/MODULE_NAME/manifests/params.pp
#
# Synopsis:
#       Parameters for the MODULE_NAME puppet module.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
# Notes:
#
#       1. Default is 'present'.


class MODULE_NAME::params {

    case $::operatingsystem {
        Fedora: {

            $service_name = 'SERVICE_NAME'
            $packages = [
                'PACKAGE_NAME',
            ]

        }

        default: {
            fail ("The MODULE_NAME module is not yet supported on ${operatingsystem}.")
        }

    }

}

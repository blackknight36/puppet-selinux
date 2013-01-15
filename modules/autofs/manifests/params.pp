# modules/autofs/manifests/params.pp
#
# Synopsis:
#       Parameters for the autofs puppet module.


class autofs::params {

    case $::operatingsystem {
        Fedora: {

            $packages = [
                'autofs',
            ]
            $service_name = 'autofs'

            if  $operatingsystemrelease == 'Rawhide' or
                $operatingsystemrelease >= 16
            {
                $master_source = 'auto.master.F16+'
            } else {
                $master_source = 'auto.master'
            }

        }

        default: {
            fail ("The autofs module is not yet supported on ${operatingsystem}.")
        }

    }

}

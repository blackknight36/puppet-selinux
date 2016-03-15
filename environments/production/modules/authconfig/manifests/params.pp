# modules/authconfig/manifests/params.pp
#
# == Class: authconfig::params
#
# Parameters for the authconfig puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   Michael Watters <michael.watters@dart.biz>


class authconfig::params {

    if $::osfamily == 'RedHat' {
		$packages = [ 'authconfig', 'krb5-libs', 'pam', 'pam_krb5', 'sssd' ]

		$service_name = 'sssd'
	}

    case $::operatingsystem {
        'Fedora': {

            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= '15'
            {
                $sssd_conf = 'sssd.conf.Fedora.15+'
            } else {
                $sssd_conf = 'sssd.conf'
            }

            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= '18'
            {
                $sssd_seltype = 'sssd_conf_t'
            } else {
                $sssd_seltype = 'etc_t'
            }
		}

        'CentOS': {
			
			$sssd_conf    = 'sssd.conf.centos-7'
			$sssd_seltype = 'sssd_conf_t'
        }

        default: {
            fail ("The authconfig module is not yet supported on ${::operatingsystem}.")
        }

    }

}

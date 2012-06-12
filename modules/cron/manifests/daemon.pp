# modules/cron/manifests/classes/daemon.pp
#
# Synopsis:
#       Configures a host for the cron daemon.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE
#
# Example usage:
#
#       include cron::daemon

class cron::daemon {

    package { 'cronie':
	ensure	=> installed,
    }

    service { 'crond':
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package['cronie'],
        ],
    }

}

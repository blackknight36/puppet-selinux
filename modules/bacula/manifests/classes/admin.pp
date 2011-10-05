# /etc/puppet/modules/bacula/manifests/classes/admin.pp
#
# Synopsis:
#       Configures a host for bacula administration purposes.
#
# Parameters:
#       NONE
#
# Requires:
#       The variables $bacula_director_password and
#       $bacula_storage_daemon_password must be set with values matching those
#       given to bacula::server.
#
# Example usage:
#
#       $bacula_client_director_password = "secret1"
#       $bacula_storage_daemon_password = "secret2"
#       include bacula::admin

class bacula::admin {

    package { "bacula-traymonitor":
	ensure	=> installed,
    }

    package { "bacula-console-bat":
	ensure	=> installed,
    }

    file { "/etc/bacula/tray-monitor.conf":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["bacula-traymonitor"],
        source  => "puppet:///bacula/tray-monitor.conf",
    }

    file { "/etc/bacula/bat.conf":
        group	=> "root",
        mode    => 640,
        owner   => "root",
        require => Package["bacula-console-bat"],
        source  => "puppet:///bacula/bat.conf",
    }

}

# /etc/puppet/modules/bacula/manifests/classes/admin.pp

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

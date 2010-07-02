# /etc/puppet/modules/bacula_admin/manifests/init.pp

class bacula_admin {

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
        source  => "puppet:///bacula_admin/tray-monitor.conf",
    }

    file { "/etc/bat.conf":
        group	=> "root",
        mode    => 640,
        owner   => "root",
        require => Package["bacula-console-bat"],
        source  => "puppet:///bacula_admin/bat.conf",
    }

}

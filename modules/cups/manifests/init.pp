# /etc/puppet/modules/cups/manifests/init.pp

class cups {

    package { "cups":
	ensure	=> installed,
    }

    file { "/etc/cups/classes.conf":
        group	=> "lp",
        mode    => 600,
        owner   => "root",
        require => Package["cups"],
        source  => "puppet:///cups/classes.conf",
    }

    file { "/etc/cups/ppd/brother.ppd":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["cups"],
        source  => "puppet:///cups/brother.ppd",
    }

    file { "/etc/cups/printers.conf":
        group	=> "lp",
        mode    => 600,
        owner   => "root",
        require => Package["cups"],
        source  => "puppet:///cups/printers.conf",
    }

    file { "/etc/cups/subscriptions.conf":
        group	=> "lp",
        mode    => 640,
        owner   => "root",
        require => Package["cups"],
        source  => "puppet:///cups/printers.conf",
    }

    service { "cups":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["cups"],
        ],
        subscribe	=> [
            File["/etc/cups/classes.conf"],
            File["/etc/cups/ppd/brother.ppd"],
            File["/etc/cups/printers.conf"],
            File["/etc/cups/subscriptions.conf"],
        ]
    }

}

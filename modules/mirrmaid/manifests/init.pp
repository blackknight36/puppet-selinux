# /etc/puppet/modules/mirrmaid/manifests/init.pp

class mirrmaid {

    package { "mirrmaid":
        ensure  => installed,
    }

    file { "/etc/mirrmaid/mirrmaid.conf":
        group   => "mirrmaid",
        mode    => "0644",
        owner   => "root",
        require => Package["mirrmaid"],
        source  => "puppet:///private-host/mirrmaid/mirrmaid.conf",
    }

    file { "/etc/mirrmaid/.ssh":
        ensure  => directory,
        force   => true,
        group   => "mirrmaid",
        mode    => "0600",      # puppet will +x for directories
        owner   => "mirrmaid",
        purge   => true,
        recurse => true,
        require => Package["mirrmaid"],
        source  => "puppet:///private-host/mirrmaid/.ssh",
    }

    file { "/etc/cron.d/mirrmaid":
        group   => "root",
        mode    => "0644",
        owner   => "root",
        require => [
            File["/etc/mirrmaid/mirrmaid.conf"],
            Package["mirrmaid"],
        ],
        source  => "puppet:///private-host/mirrmaid/mirrmaid.cron",
    }

}

# modules/sudo/manifests/init.pp

class sudo {

    package { "sudo":
        ensure  => installed
    }

    if  $operatingsystem == "Fedora" and
        $operatingsystemrelease == 'Rawhide' or
        $operatingsystemrelease >= 13
    {

        file { "/etc/sudoers.d/mdct":
            group   => "root",
            mode    => 440,
            owner   => "root",
            require => Package["sudo"],
            source  => [
                "puppet:///modules/sudo/sudoers.$hostname",
                "puppet:///modules/sudo/sudoers.mdct",
            ],
        }

    }

}

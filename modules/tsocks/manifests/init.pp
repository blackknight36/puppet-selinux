# modules/tsocks/manifests/init.pp

class tsocks {

    if  $operatingsystem == "Fedora" and
        $operatingsystemrelease == 'Rawhide' or
        $operatingsystemrelease >= 11
    {

        package { "tsocks":
            ensure	=> installed,
        }

        file { "/etc/tsocks.conf":
            group	=> "root",
            mode    => 644,
            owner   => "root",
            require => Package["tsocks"],
            source  => "puppet:///modules/tsocks/tsocks.conf",
        }

    }

}

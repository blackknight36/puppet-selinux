# /etc/puppet/modules/tsocks/manifests/init.pp

class tsocks {

    if ( $operatingsystem == "Fedora" ) and ($operatingsystemrelease >= 11) {

        package { "tsocks":
            ensure	=> installed,
        }

        file { "/etc/tsocks.conf":
            group	=> "root",
            mode    => 644,
            owner   => "root",
            require => Package["tsocks"],
            source  => "puppet:///tsocks/tsocks.conf",
        }

    }

}

# modules/sudo/manifests/init.pp

class sudo {

    package { "sudo":
	ensure	=> installed
    }

    if $operatingsystem == "Fedora" {

        if $operatingsystemrelease < 13 {

            file { "/etc/sudoers":
                group	=> "root",
                mode    => 440,
                owner   => "root",
                require => Package["sudo"],
                source  => [
                    "puppet:///sudo/sudoers.$hostname",
                    "puppet:///sudo/sudoers.preF13",
                ],
            }

        } else {

            file { "/etc/sudoers.d/mdct":
                group	=> "root",
                mode    => 440,
                owner   => "root",
                require => Package["sudo"],
                source  => [
                    "puppet:///sudo/sudoers.$hostname",
                    "puppet:///sudo/sudoers.mdct",
                ],
            }

        }

    }
}

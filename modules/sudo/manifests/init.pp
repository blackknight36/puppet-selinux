# /etc/puppet/modules/sudo/manifests/init.pp

class sudo {

    package { "sudo":
	ensure	=> installed
    }

    file { "/etc/sudoers":
        group	=> "root",
        mode    => 440,
        owner   => "root",
        require => Package["sudo"],
        source  => [
            "puppet:///sudo/sudoers.$hostname",
            "puppet:///sudo/sudoers",
        ],
    }
}

# /etc/puppet/modules/repoview/manifests/init.pp

class repoview {

    package { "repoview":
	ensure	=> installed,
    }

    file { "/etc/cron.d/mdct-repoview":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        require => [
            #Service["crond"],  # if there were such a module
            Package["repoview"],
        ],
        source  => "puppet:///modules/repoview/mdct-repoview",
    }

}

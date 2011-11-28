# modules/flock-herder/manifests/init.pp

class flock-herder {

    package { "flock-herder":
	ensure	=> latest,
    }

    # Older puppets cannot cope with this style of source w/o generating
    # warnings (that really should be info instead).  See
    # http://projects.puppetlabs.com/issues/2577 for details.
    if $operatingsystemrelease > 10 {
        file { "/etc/herd.conf":
            group	=> "root",
            mode    => "0644",
            owner   => "root",
            require => Package["flock-herder"],
            seluser => "system_u",
            selrole => "object_r",
            seltype => "etc_t",
            source  => [
                "puppet:///private-host/flock-herder/herd.conf",
                "puppet:///modules/flock-herder/herd.conf",
            ],
        }
    }

}

# modules/flock_herder/manifests/init.pp

class flock_herder {

    package { "flock-herder":
        ensure  => latest,
    }

    file { "/etc/herd.conf":
        group   => "root",
        mode    => "0644",
        owner   => "root",
        require => Package["flock-herder"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "etc_t",
        source  => [
            "puppet:///private-host/flock_herder/herd.conf",
            "puppet:///modules/flock_herder/herd.conf",
        ],
    }

}

# modules/flock-herder/manifests/init.pp

class flock-herder {

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
            "puppet:///private-host/flock-herder/herd.conf",
            "puppet:///modules/flock-herder/herd.conf",
        ],
    }

}

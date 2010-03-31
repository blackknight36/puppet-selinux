# /etc/puppet/modules/timezone/manifests/init.pp

class timezone {

    file { "/etc/sysconfig/clock":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        source  => "puppet:///timezone/clock",
    }

    file { "/etc/localtime":
        ensure  => "/usr/share/zoneinfo/America/Detroit"
    }

}

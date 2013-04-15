# modules/ipmi/manifests/init.pp

class ipmi {

    package { ["OpenIPMI", "ipmiutil", "ipmitool"]:
        ensure => installed
    }

    file { "ipmi_conf":
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        path    => "/etc/modules-load.d/ipmi",
        require => Package["OpenIPMI", "ipmiutil", "ipmitool"],
        source  => "puppet:///modules/ipmi/ipmi",
    }

}

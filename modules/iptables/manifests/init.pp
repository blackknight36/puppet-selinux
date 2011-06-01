# /etc/puppet/modules/iptables/manifests/init.pp

class iptables {

    package { "iptables":
	ensure	=> installed,
    }

    service { "iptables":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["iptables"],
        ],
    }

}

# /etc/puppet/modules/pkgs_net_tools/manifests/init.pp

class pkgs_net_tools {

    package { "mtr":
	ensure	=> installed,
    }

    package { "wireshark-gnome":
	ensure	=> installed,
    }

}

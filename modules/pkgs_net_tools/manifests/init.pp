# /etc/puppet/modules/pkgs_net_tools/manifests/init.pp

class pkgs_net_tools {

    package { "bridge-utils":
	ensure	=> installed,
    }

    package { "nmap":
	ensure	=> installed,
    }

    package { "mtr":
	ensure	=> installed,
    }

    # tsocks gets its own module
    include tsocks

    package { "wireshark-gnome":
	ensure	=> installed,
    }

}

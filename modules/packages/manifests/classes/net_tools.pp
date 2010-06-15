# /etc/puppet/modules/packages/manifests/classes/net_tools.pp

class packages::net_tools {

    package { "bridge-utils":
	ensure	=> installed,
    }

    package { "enmasse":
	ensure	=> installed,
    }

    package { "mtr":
	ensure	=> installed,
    }

    package { "nmap":
	ensure	=> installed,
    }

    package { "openldap-clients":
	ensure	=> installed,
    }

    # tsocks gets its own module
    include tsocks

    package { "wireshark-gnome":
	ensure	=> installed,
    }

}

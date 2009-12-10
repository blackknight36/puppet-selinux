# /etc/puppet/modules/pkgs_base/manifests/init.pp

class pkgs_base {

    package { "bash-completion":
	ensure	=> installed,
    }

    package { "gpm":
	ensure	=> installed,
    }

    if $operatingsystemrelease >= 10 {
	package { "task":
	    ensure	=> installed,
	}
    }

    package { "prophile":
	ensure	=> installed,
    }

    package { "units":
	ensure	=> installed,
    }

    package { "vim-enhanced":
	ensure	=> installed,
    }

    package { "vim-X11":
	ensure	=> installed,
    }

}

# /etc/puppet/modules/pkgs_workstation/manifests/init.pp

class pkgs_workstation {

    package { "firefox":
	ensure	=> installed,
    }

    package { "galculator":
	ensure	=> installed,
    }

    package { "openoffice.org-calc":
	ensure	=> installed,
    }

    package { "openoffice.org-writer":
	ensure	=> installed,
    }

    package { "workrave":
	ensure	=> installed,
    }

    package { "xclip":
	ensure	=> installed,
    }

}

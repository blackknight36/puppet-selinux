# /etc/puppet/modules/pkgs_developer/manifests/init.pp

class pkgs_developer {

    package { "cvs":
	ensure	=> installed,
    }

    package { "git":
	ensure	=> installed,
    }

    package { "python-devel":
	ensure	=> installed,
    }

    package { "rpmdevtools":
	ensure	=> installed,
    }

    package { "subversion":
	ensure	=> installed,
    }

}

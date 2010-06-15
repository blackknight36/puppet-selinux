# /etc/puppet/modules/packages/manifests/classes/developer.pp

class packages::developer {

    package { "builder":
	ensure	=> installed,
    }

    package { "cvs":
	ensure	=> installed,
    }

    package { "git":
	ensure	=> installed,
    }

    package { "gitk":
	ensure	=> installed,
    }

    package { "python-devel":
	ensure	=> installed,
    }

    package { "repoview":
	ensure	=> installed,
    }

    package { "rpmdevtools":
	ensure	=> installed,
    }

    package { "subversion":
	ensure	=> installed,
    }

}

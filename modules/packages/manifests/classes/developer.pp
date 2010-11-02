# /etc/puppet/modules/packages/manifests/classes/developer.pp

class packages::developer {

    include rpm-build-tools

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

    # required for: rpmbuild --sign
    package { "gnupg":
	ensure	=> installed,
    }

    package { "gnupg2":
	ensure	=> installed,
    }

    package { "nasm":
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

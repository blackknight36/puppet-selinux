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

    # required for: rpmbuild --sign
    package { "gnupg":
	ensure	=> installed,
    }

    package { "gnupg2":
	ensure	=> installed,
    }

    package { "python-devel":
	ensure	=> installed,
    }

    # NB: Configuration file for rpm-build-tools is provided, but only for build_server_nodes since other
    # developers may want slightly different configs.
    # See also: modules/dart/manifests/classes/build_server_node.pp.
    if $operatingsystemrelease != "10" {
        package { "rpm-build-tools":
            ensure	=> installed,
        }
    }

    package { "rpmdevtools":
	ensure	=> installed,
    }

    package { "subversion":
	ensure	=> installed,
    }

}

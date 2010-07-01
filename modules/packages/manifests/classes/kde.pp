# /etc/puppet/modules/packages/manifests/classes/kde.pp

class packages::kde {

    package { "amarok":
	ensure	=> installed,
    }

    package { "k3b":
	ensure	=> installed,
    }

    package { "k3b-extras-freeworld":
	ensure	=> installed,
    }

    package { "kdeartwork":
	ensure	=> installed,
    }

    package { "kmplayer":
	ensure	=> installed,
    }

    package { "koffice-krita":
	ensure	=> installed,
    }

    package { "phonon-backend-gstreamer":
	ensure	=> installed,
    }

}

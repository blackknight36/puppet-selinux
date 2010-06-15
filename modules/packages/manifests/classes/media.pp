# /etc/puppet/modules/packages/manifests/classes/media.pp

class packages::media {

    package { "amarok":
	ensure	=> installed,
    }

    package { "easytag":
	ensure	=> installed,
    }

    package { "gecko-mediaplayer":
	ensure	=> installed,
    }

    package { "gimp":
	ensure	=> installed,
    }

    package { "gqview":
	ensure	=> installed,
    }

    package { "gstreamer-ffmpeg":
	ensure	=> installed,
    }

    if $operatingsystemrelease < 12 {
        package { "gstreamer-plugins-bad":
            ensure	=> installed,
        }
    }

    package { "gstreamer-plugins-ugly":
	ensure	=> installed,
    }

    package { "ImageMagick":
	ensure	=> installed,
    }

    package { "k3b":
	ensure	=> installed,
    }

    package { "k3b-extras-freeworld":
	ensure	=> installed,
    }

    package { "kmplayer":
	ensure	=> installed,
    }

    package { "koffice-krita":
	ensure	=> installed,
    }

    package { "lame":
	ensure	=> installed,
    }

    package { "mp3gain":
	ensure	=> installed,
    }

    package { "mplayer":
	ensure	=> installed,
    }

    package { "xine-lib-extras-freeworld":
	ensure	=> installed,
    }

    package { "xsane":
	ensure	=> installed,
    }

}

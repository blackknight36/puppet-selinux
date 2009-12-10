# /etc/puppet/modules/pkgs_media/manifests/init.pp

class pkgs_media {

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

    package { "gstreamer-plugins-bad":
	ensure	=> installed,
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

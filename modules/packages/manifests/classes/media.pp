# /etc/puppet/modules/packages/manifests/classes/media.pp

# See also packages::kde.

class packages::media {

    package { "easytag":
	ensure	=> installed,
    }

    package { "gecko-mediaplayer":
	ensure	=> installed,
    }

    package { "gimp":
	ensure	=> installed,
    }

    # gqview was retired for Fedora 14 and has been replaced with a fork named geeqie.
    if $operatingsystemrelease < 14 {
        package { "gqview":
            ensure	=> installed,
        }
    } else {
        package { "geeqie":
            ensure	=> installed,
        }
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

# /etc/puppet/modules/pkgs_32bit_compat/manifests/init.pp

class pkgs_32bit_compat {

    package { "fontconfig.i586":
        ensure  => installed,
    }

    package { "freetype.i586":
        ensure  => installed,
    }

    package { "glib2.i586":
        ensure  => installed,
    }

    package { "glibc.i686":
        ensure  => installed,
    }

    package { "libSM.i586":
        ensure  => installed,
    }

    package { "libXext.i586":
        ensure  => installed,
    }

    package { "libXi.i586":
        ensure  => installed,
    }

    package { "libXrandr.i586":
        ensure  => installed,
    }

    package { "libXrender.i586":
        ensure  => installed,
    }

    package { "libXtst.i586":
        ensure  => installed,
    }

}

# /etc/puppet/modules/pkgs_32bit_compat/manifests/init.pp

class pkgs_32bit_compat {

    $ALT_ARCH = $operatingsystem ? {
        centos      => $lsbmajdistrelease ? {
            5   =>      "i386",
        },
        Fedora      => $operatingsystemrelease ? {
            8   =>      "i386",
            10  =>      "i386",
            11  =>      "i586",
            12  =>      "i686",
        },
    }

    package { "fontconfig.$ALT_ARCH":
        ensure  => installed,
    }

    package { "freetype.$ALT_ARCH":
        ensure  => installed,
    }

    package { "glib2.$ALT_ARCH":
        ensure  => installed,
    }

    package { "glibc.i686":
        ensure  => installed,
    }

    package { "libSM.$ALT_ARCH":
        ensure  => installed,
    }

    package { "libXext.$ALT_ARCH":
        ensure  => installed,
    }

    package { "libXi.$ALT_ARCH":
        ensure  => installed,
    }

    package { "libXrandr.$ALT_ARCH":
        ensure  => installed,
    }

    package { "libXrender.$ALT_ARCH":
        ensure  => installed,
    }

    package { "libXtst.$ALT_ARCH":
        ensure  => installed,
    }

}

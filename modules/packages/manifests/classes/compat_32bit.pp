# /etc/puppet/modules/packages/manifests/classes/compat_32bit.pp

class packages::compat_32bit {

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

    # GConf2 needed for at least Lotus Notes
    package { "GConf2.$ALT_ARCH":
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

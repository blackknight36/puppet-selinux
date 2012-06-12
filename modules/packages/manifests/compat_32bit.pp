# modules/packages/manifests/compat_32bit.pp

class packages::compat_32bit {

    $ALT_ARCH = $operatingsystem ? {
        centos      => $lsbmajdistrelease ? {
            5   =>      "i386",
        },
        Fedora      => $operatingsystemrelease ? {
            8   =>      "i386",
            10  =>      "i386",
            11  =>      "i586",
        },
    }

    ### Universal Package Inclusion ###

    package { [

        "GConf2.$ALT_ARCH", # needed by at least Lotus Notes
        "fontconfig.$ALT_ARCH",
        "freetype.$ALT_ARCH",
        "glib2.$ALT_ARCH",
        "glibc.i686",
        "libSM.$ALT_ARCH",
        "libXext.$ALT_ARCH",
        "libXi.$ALT_ARCH",
        "libXrandr.$ALT_ARCH",
        "libXrender.$ALT_ARCH",
        "libXtst.$ALT_ARCH",

        ]:
        ensure => installed,
    }

}

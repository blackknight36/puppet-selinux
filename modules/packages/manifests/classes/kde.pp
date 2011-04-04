# /etc/puppet/modules/packages/manifests/classes/kde.pp

class packages::kde {

    package { "amarok":
        ensure  => installed,
    }

    package { "cups-pk-helper":
        ensure  => installed,
    }

    package { "digikam":
        ensure  => installed,
    }

    package { "k3b":
        ensure  => installed,
    }

    package { "k3b-extras-freeworld":
        ensure  => installed,
    }

    package { "kaffeine":
        ensure  => installed,
    }

    package { "kbluetooth":
        ensure  => installed,
    }

    package { "kcm-gtk":
        ensure  => installed,
    }

    package { "kcm_touchpad":
        ensure  => installed,
    }

    package { "kde-plasma-networkmanagement":
        ensure  => installed,
    }

    package { "kde-plasma-yawp":
        ensure  => installed,
    }

    package { "kde-settings-pulseaudio":
        ensure  => installed,
    }

    package { "kdeaccessibility":
        ensure  => installed,
    }

    package { "kdeartwork":
        ensure  => installed,
    }

    package { "kdeartwork-screensavers":
        ensure  => installed,
    }

    package { "kdebase":
        ensure  => installed,
    }

    package { "plasma-scriptengine-python":
        ensure  => installed,
    }

    package { "kdegames":
        ensure  => installed,
    }

    package { "kdegraphics":
        ensure  => installed,
    }

    package { "kdemultimedia":
        ensure  => installed,
    }

    package { "kdenetwork":
        ensure  => installed,
    }

    package { "kdepim":
        ensure  => installed,
    }

    package { "kdeplasma-addons":
        ensure  => installed,
    }

    package { "kdeutils":
        ensure  => installed,
    }

    package { "kdeutils-printer-applet":
        ensure  => installed,
    }

    package { "kdm":
        ensure  => installed,
    }

    package { "kipi-plugins":
        ensure  => installed,
    }

    package { "kmplayer":
        ensure  => installed,
    }

    package { "koffice-krita":
        ensure  => installed,
    }

    package { "konq-plugins":
        ensure  => installed,
    }

    package { "konversation":
        ensure  => installed,
    }

    package { "kpackagekit":
        ensure  => installed,
    }

    package { "ksshaskpass":
        ensure  => installed,
    }

    package { "ktorrent":
        ensure  => installed,
    }

    package { "phonon-backend-gstreamer":
        ensure  => installed,
    }

    package { "pinentry-qt":
        ensure  => installed,
    }

    package { "qtcurve-gtk2":
        ensure  => installed,
    }

    package { "qtcurve-kde4":
        ensure  => installed,
    }

    package { "scribus":
        ensure  => installed,
    }

    package { "system-config-printer-kde":
        ensure  => installed,
    }

    package { "xorg-x11-apps":
        ensure  => installed,
    }

    package { "xsettings-kde":
        ensure  => installed,
    }

}

# modules/packages/manifests/classes/kde.pp

class packages::kde {

    ### Universal Package Inclusion ###

    package { [

        'amarok',
        'cups-pk-helper',
        'digikam',
        'k3b',
        'k3b-extras-freeworld',
        'kaffeine',
        'kcm-gtk',
        'kcm_touchpad',
        'kde-plasma-networkmanagement',
        'kde-plasma-yawp',
        'kdeaccessibility',
        'kdeartwork',
        'kdeartwork-screensavers',
        'kdegames',
        'kdegraphics',
        'kdemultimedia',
        'kdenetwork',
        'kdepim',
        'kdeplasma-addons',
        'kdeutils',
        'kdeutils-printer-applet',
        'kdm',
        'kipi-plugins',
        'kmplayer',
        'koffice-krita',
        'konversation',
        'ksshaskpass',
        'ktorrent',
        'phonon-backend-gstreamer',
        'pinentry-qt',
        'plasma-scriptengine-python',
        'qtcurve-gtk2',
        'qtcurve-kde4',
        'scribus',
        'system-config-printer-kde',
        'xorg-x11-apps',
        'xsettings-kde',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $operatingsystem == 'Fedora' {

        if $operatingsystemrelease >= 16 {
            package { [
                'kde-baseapps',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'kdebase',
                ]:
                ensure => installed,
            }
        }

    }

}

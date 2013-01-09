# modules/packages/manifests/kde.pp

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
        'kdm',
        'kipi-plugins',
        'kmplayer',
        'konversation',
        'ksshaskpass',
        'ktorrent',
        'phonon-backend-gstreamer',
        'pinentry-qt',
        'plasma-scriptengine-python',
        'qtcurve-gtk2',
        'qtcurve-kde4',
        'scribus',
        'xorg-x11-apps',
        'xsettings-kde',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $operatingsystem == 'Fedora' {

        if  $operatingsystemrelease == 'Rawhide' or
            $operatingsystemrelease >= 18
        {
            package { [
                'kde-print-manager',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'system-config-printer-kde',
                ]:
                ensure => installed,
            }
        }

        if  $operatingsystemrelease == 'Rawhide' or
            $operatingsystemrelease >= 17
        {
            package { [
                'calligra-krita',
                'kde-baseapps',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'koffice-krita',
                ]:
                ensure => installed,
            }
        }

    }

}

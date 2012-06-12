# modules/packages/manifests/classes/media.pp

# See also packages::kde.

class packages::media {

    ### Universal Package Inclusion ###

    package { [

        'ImageMagick',
        'easytag',
        'esound-libs',
        'gecko-mediaplayer',
        'gimp',
        'gstreamer-ffmpeg',
        'gstreamer-plugins-bad',
        'gstreamer-plugins-ugly',
        'lame',
        'mp3gain',
        'mplayer',
        'pulseaudio-esound-compat',
        'xine-lib-extras-freeworld',
        'xsane',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $operatingsystem == 'Fedora' {

        if $operatingsystemrelease >= 14 {
            package { [
                'geeqie',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'gqview',
                ]:
                ensure => installed,
            }
        }

    }

    ### Universal Package Exclusion ###

    package { [

        ]:
        ensure => absent,
    }

    ### Select Package Exclusion ###

    # none

}

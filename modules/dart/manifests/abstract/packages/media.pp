# modules/dart/manifests/abstract/packages/media.pp

class dart::abstract::packages::media {

    ### Universal Package Inclusion ###

    package { [

        'ImageMagick',
        'clementine',
        'easytag',
        'esound-libs',
        'ffmpeg',
        'gecko-mediaplayer',
        'gimp',
        'gstreamer-ffmpeg',
        'gstreamer-plugins-bad',
        'gstreamer-plugins-bad-free',
        'gstreamer-plugins-bad-nonfree',
        'gstreamer-plugins-good',
        'gstreamer-plugins-ugly',
        'gstreamer1-libav',
        'gstreamer1-plugins-bad-free',
        'gstreamer1-plugins-good',
        'gstreamer1-plugins-ugly',
        'lame',
        'mp3gain',
        'mplayer',
        'pulseaudio-esound-compat',
        'xsane',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $::operatingsystem == 'Fedora' {

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 14
        {
            package {
                [
                    'geeqie',
                ]:
                ensure => installed,
            }
        }

        if  $::operatingsystemrelease < 20
        {
            package {
                [
                    'xine-lib-extras-freeworld',
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

# /etc/puppet/modules/dart/manifests/abstract/packages/workstation.pp

class dart::abstract::packages::workstation {

    ### Universal Package Inclusion ###

    include 'lyx'
    include 'openjdk::workstation'

    package { [

        'builder',
        'evolution',
        'evolution-ews',
        'firefox',
        'freerdp',
        'galculator',
        'okular',
        'pavucontrol',
        'plant-launchers',
        'putty',
        'rdesktop',
        'spice-xpi',
        'xclip',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $::operatingsystem == 'Fedora' {

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= '21'
        {
            package { [
                'adobe-source-code-pro-fonts',
                'google-roboto-fonts',
                'google-roboto-mono-fonts',
                ]:
                ensure => installed,
            }
        } elsif  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= '18'
        {
            package { [
                'libreoffice-calc',
                'libreoffice-writer',
                'systemd-ui',
                ]:
                ensure => installed,
            }
        } elsif $::operatingsystemrelease >= '15' {
            package { [
                'libreoffice-calc',
                'libreoffice-writer',
                'systemd-gtk',
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

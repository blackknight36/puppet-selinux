# /etc/puppet/modules/dart/manifests/abstract/packages/workstation.pp

class dart::abstract::packages::workstation {

    ### Universal Package Inclusion ###

    include 'lyx'

    package { [

        'builder',
        'evolution',
        'evolution-ews',
        'firefox',
        'galculator',
        'pavucontrol',
        'plant-launchers',
        'putty',
        'rdesktop',
        'xclip',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $::operatingsystem == 'Fedora' {

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 18
        {
            package { [
                'libreoffice-calc',
                'libreoffice-writer',
                'systemd-ui',
                ]:
                ensure => installed,
            }
        } elsif $::operatingsystemrelease >= 15 {
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

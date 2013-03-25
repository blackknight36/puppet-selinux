# modules/packages/manifests/workstation.pp

class packages::workstation {

    ### Universal Package Inclusion ###

    package { [

        'builder',
        'firefox',
        'galculator',
        'lyx',
        'pavucontrol',
        'plant-launchers',
        'putty',
        'qcad',
        'xclip',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $operatingsystem == 'Fedora' {

        if  $operatingsystemrelease == 'Rawhide' or
            $operatingsystemrelease >= 18
        {
            package { [
                'libreoffice-calc',
                'libreoffice-writer',
                'systemd-ui',
                ]:
                ensure => installed,
            }
        } elsif $operatingsystemrelease >= 15 {
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

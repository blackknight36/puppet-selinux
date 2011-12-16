# modules/packages/manifests/classes/workstation.pp

class packages::workstation {

    ### Universal Package Inclusion ###

    package { [

        'bluecurve-cursor-theme',       # provides left-handed cursors
        'builder',
        'firefox',
        'galculator',
        'lyx',
        'pavucontrol',
        'plant-launchers',
        'putty',
        'qcad',
        'synergy',
        'test-automation',
        'workrave',
        'xclip',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $operatingsystem == 'Fedora' {

        if $operatingsystemrelease >= 11 {
            package { [
                'tigervnc',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'vnc',
                ]:
                ensure => installed,
            }
        }

        if $operatingsystemrelease >= 14 {
            package { [
                'mysql-workbench',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'mysql-query-browser',
                ]:
                ensure => installed,
            }
        }

        if $operatingsystemrelease >= 15 {
            package { [
                'libreoffice-calc',
                'libreoffice-writer',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'openoffice.org-calc',
                'openoffice.org-writer',
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

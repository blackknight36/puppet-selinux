# /etc/puppet/modules/packages/manifests/classes/workstation.pp

class packages::workstation {

    # One of the very few that provides left-handed cursors.
    package { "bluecurve-cursor-theme":
        ensure  => installed,
    }

    package { "builder":
        ensure  => installed,
    }

    package { "firefox":
        ensure  => installed,
    }

    package { "flock-herder":
        ensure  => installed,
    }

    package { "galculator":
        ensure  => installed,
    }

    package { "lyx":
        ensure  => installed,
    }

    # MQB was dropped (by Fedora) due to excessive bugs and replaced with mysql-workbench.
    if $operatingsystemrelease < 13 {
        package { "mysql-query-browser":
            ensure      => installed,
        }
    } else {
        package { "mysql-workbench":
            ensure      => installed,
        }
    }

    package { "openoffice.org-calc":
        ensure  => installed,
    }

    package { "openoffice.org-writer":
        ensure  => installed,
    }

    package { "pavucontrol":
        ensure  => installed,
    }

    package { "plant-launchers":
        ensure  => installed,
    }

    package { "test-automation":
        ensure  => installed,
    }

    package { "usbutils":
        ensure  => installed,
    }

    if $operatingsystemrelease > 10 {
        $vncviewer = "tigervnc"
    } else {
        $vncviewer = "vnc"
    }
    package { "${vncviewer}":
        ensure  => installed,
    }

    package { "workrave":
        ensure  => installed,
    }

    package { "x2vnc":
        ensure  => installed,
    }

    package { "xclip":
        ensure  => installed,
    }

}

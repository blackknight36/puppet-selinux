# /etc/puppet/modules/packages/manifests/classes/workstation.pp

class packages::workstation {

    # One of the very few that provides left-handed cursors.
    package { "bluecurve-cursor-theme":
	ensure	=> installed,
    }

    package { "builder":
	ensure	=> installed,
    }

    package { "firefox":
	ensure	=> installed,
    }

    package { "flock-herder":
	ensure	=> installed,
    }

    package { "galculator":
	ensure	=> installed,
    }

    package { "lyx":
	ensure	=> installed,
    }

    # MQB has been dropped due to excessive bugs.  Eventually to be replaced
    # by mysql-workbench, which is not available as of yet.  For details, see:
    # http://www.shekhargovindarajan.com/open-source/mysql-gui-tools-query-browser-administrator-for-fedora-13/
    if $operatingsystemrelease < 13 {
        package { "mysql-query-browser":
            ensure	=> installed,
        }
    }

    package { "openoffice.org-calc":
	ensure	=> installed,
    }

    package { "openoffice.org-writer":
	ensure	=> installed,
    }

    package { "plant-launchers":
	ensure	=> installed,
    }

    package { "test-automation":
	ensure	=> installed,
    }

    if $operatingsystemrelease > 10 {
        $vncviewer = "tigervnc"
    } else {
        $vncviewer = "vnc"
    }
    package { "${vncviewer}":
	ensure	=> installed,
    }

    package { "workrave":
	ensure	=> installed,
    }

    package { "x2vnc":
	ensure	=> installed,
    }

    package { "xclip":
	ensure	=> installed,
    }

}

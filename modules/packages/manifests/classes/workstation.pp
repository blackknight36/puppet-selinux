# /etc/puppet/modules/packages/manifests/classes/workstation.pp

class packages::workstation {

    package { "firefox":
	ensure	=> installed,
    }

    package { "flock-herder":
	ensure	=> installed,
    }

    package { "galculator":
	ensure	=> installed,
    }

    package { "mysql-query-browser":
	ensure	=> installed,
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

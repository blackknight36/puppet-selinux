# /etc/puppet/modules/packages/manifests/classes/base.pp

class packages::base {

    # These work fine for Fedora 11.  In Fedora 12, all packages on 32-bit
    # architecture have been compiled fo i686 systems.  Trying to simply
    # install foo.i686 now fails as it conflicts with foo.x86_64.  In Fedora
    # 11, it was possible to install foo.i586 (and even glibc.i686) alongside
    # foo.x86_64.  Maybe these simply aren't needed anymore?
    #
    # Fedora 8 only has glibc and at this point, it isn't worth getting picky.
    if ($architecture == "x86_64") and ($operatingsystemrelease > 8) and ($operatingsystemrelease <= 11) {
        include packages::compat_32bit
    }

    package { "bash-completion":
	ensure	=> installed,
    }

    # DejaVu LGC fonts are used by vim-X11.
    if $operatingsystemrelease >= 11 {
        package { "dejavu-lgc-sans-mono-fonts":
            ensure	=> installed,
        }
    }
    else {
        package { "dejavu-lgc-fonts":
            ensure	=> installed,
        }
    }

    package { "expect":
	ensure	=> installed,
    }

    package { "gpm":
	ensure	=> installed,
    }

    package { "iotop":
	ensure	=> installed,
    }

    if $operatingsystemrelease >= 10 {
	package { "task":
	    ensure	=> installed,
	}
    }

    package { "prophile":
	ensure	=> installed,
    }

    package { "python-mdct":
	ensure	=> installed,
    }

    package { "units":
	ensure	=> installed,
    }

    package { "vim-enhanced":
	ensure	=> installed,
    }

    package { "vim-X11":
	ensure	=> installed,
    }

}

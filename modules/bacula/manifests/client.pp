# modules/bacula/manifests/client.pp

class bacula::client {

    include lokkit

    # We've moved to Bacula 5.x.
    #
    # F12 and later make the default bacula packages use a newer major version
    # that is not backwards compatible with a Bacula 2.x server.  They do
    # however offer a "bacula2" series of packges that provide 2.x (2.4.4 at
    # this time) for compatiblity with older Bacula server deployments.
    if $operatingsystem == "Fedora" and $operatingsystemrelease >= 12 {
        $bacula_major = "bacula"
        $conflict_major = "bacula2"
        # The migration to systemd also introduced other subtle configuration
        # changes that must be reflected here.
        if $operatingsystemrelease >= 15 {
            $ossuffix='.Fedora15+'
        } else {
            $ossuffix=''
        }
    } else {
        $bacula_major = "bacula"
        $conflict_major = undef
        $ossuffix=''
    }

    # Fedora packages Bacula so that multiple major versions can coexist.  We
    # only need one of them and force the absence of the other primarily to
    # ensure that the other has already been configured and has a service
    # started and listening on the reserved port.  Essentially, we're evicting
    # any potential port squatter.
    if "${conflict_major}" != undef {
        package { "${conflict_major}-client":
            ensure      => absent,
        }
        package { "${conflict_major}-common":
            ensure      => absent,
        }
        $conflict_packages = [
            Package["${conflict_major}-client"],
            Package["${conflict_major}-common"],
        ]
    } else {
        $conflict_packages = undef
    }

    package { "${bacula_major}-client":
	ensure	=> installed,
        require => $conflict_packages,
    }

    file { "/etc/${bacula_major}/bacula-fd.conf":
	content	=> template("bacula/bacula-fd.conf"),
        group	=> "root",
        mode    => 640,
        owner   => "root",
        require => Package["${bacula_major}-client"],
    }

    file { "/etc/sysconfig/${bacula_major}-fd":
        group	=> "root",
        mode    => 640,
        owner   => "root",
        require => Package["${bacula_major}-client"],
        source  => "puppet:///modules/bacula/bacula-fd${ossuffix}",
    }

    lokkit::tcp_port { "bacula-fd":
        port    => "9102",
    }

    service { "${bacula_major}-fd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-bacula-fd-tcp-port"],
            Package["${bacula_major}-client"],
        ],
        subscribe	=> [
            File["/etc/${bacula_major}/bacula-fd.conf"],
            File["/etc/sysconfig/${bacula_major}-fd"],
        ]
    }

}

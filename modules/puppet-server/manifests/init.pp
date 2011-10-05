# /etc/puppet/modules/puppet-server/manifests/init.pp

class puppet-server {

    include lokkit

    package { "puppet-server":
	ensure	=> installed,
    }

    package { "puppet-tools":
	ensure	=> installed,
    }

    # Not managed here, but vital:
    #   /etc/puppet             (rsync to replacement host; note the local git
    #                            repository)
    #   /var/lib/puppet         (rsync to replacement host)
    #   hostname must be mdct-puppet.dartcontainer.com
    #   ip address must be 10.1.192.131


    lokkit::tcp_port { "puppetmaster":
        port    => "8140",
    }

    service { "puppetmaster":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-puppetmaster-tcp-port"],
            Package["puppet-server"],
        ],
    }

}

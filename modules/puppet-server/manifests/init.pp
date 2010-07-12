# /etc/puppet/modules/puppet-server/manifests/init.pp

class puppet-server {

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


    exec { "open-puppetmaster-port":
        command => "lokkit --port=8140:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 8140 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "puppetmaster":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-puppetmaster-port"],
            Package["puppet-server"],
        ],
    }

}

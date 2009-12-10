# /etc/puppet/modules/bacula_client/manifests/init.pp

class bacula_client {

    package { "bacula-client":
	ensure	=> installed
    }

    file { "/etc/bacula/bacula-fd.conf":
	content	=> template("bacula_client/bacula-fd.conf"),
        group	=> "root",
        mode    => 640,
        owner   => "root",
        require => Package["bacula-client"],
    }

    exec { "open-bacula-fd-port":
        command => "lokkit --port=9102:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 9102 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "bacula-fd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-bacula-fd-port"],
            Package["bacula-client"],
        ],
        subscribe	=> [
            File["/etc/bacula/bacula-fd.conf"],
        ]
    }

}

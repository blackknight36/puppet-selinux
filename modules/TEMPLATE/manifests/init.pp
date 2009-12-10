# /etc/puppet/modules/MODULE_NAME/manifests/init.pp

class MODULE_NAME {

    package { "PACKAGE_NAME":
	ensure	=> installed,
    }

    package { "CONFLICTING_PACKAGE_NAME":
	ensure	=> absent,
	# It may be necessary to have the replacement installed prior to
	# removal of the conflicting package.
        require => Package["PACKAGE_NAME"],
    }

    # static file
    file { "/CONFIG_PATH/CONFIG_NAME":
        # don't forget to verify these!
        group	=> "root",
        mode    => 640,
        owner   => "root",
        require => Package["PACKAGE_NAME"],
        source  => "puppet:///MODULE_NAME/CONFIG_NAME",
    }

    # template file
    file { "/CONFIG_PATH/CONFIG_NAME":
	content	=> template("MODULE_NAME/CONFIG_NAME"),
        # don't forget to verify these!
        group	=> "root",
        mode    => 640,
        owner   => "root",
        require => Package["PACKAGE_NAME"],
    }

    exec { "open-SERVICE_NAME-port":
        command => "lokkit --port=9102:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 9102 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "SERVICE_NAME":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-SERVICE_NAME-port"],
            Package["CONFLICTING_PACKAGE_NAME"],
            Package["PACKAGE_NAME"],
        ],
        subscribe	=> [
            File["/CONFIG_PATH/CONFIG_NAME"],
        ],
    }

}

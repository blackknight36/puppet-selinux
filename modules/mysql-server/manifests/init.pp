# /etc/puppet/modules/mysql-server/manifests/init.pp

class mysql-server {

    package { "mysql-server":
	ensure	=> installed,
    }

    service { "mysqld":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["mysql-server"],
        ],
    }

}

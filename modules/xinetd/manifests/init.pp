# modules/xinetd/manifests/init.pp

class xinetd {

    package { "xinetd":
	ensure	=> installed,
    }

    service { "xinetd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["xinetd"],
        ],
    }

}

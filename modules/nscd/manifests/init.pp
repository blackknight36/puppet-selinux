# /etc/puppet/modules/nscd/manifests/init.pp

class nscd {

    package { "nscd":
	ensure	=> installed,
    }

    service { "nscd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["nscd"],
        ],
    }

}

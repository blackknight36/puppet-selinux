# /etc/puppet/modules/nscd/manifests/init.pp

# NB: nscd *may* cause problems with the builder package, but it is essential
# to have this for reasonable system performance
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

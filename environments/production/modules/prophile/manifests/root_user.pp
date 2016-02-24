# modules/prophile/manifests/root_user.pp
#
# == Define: prophile::root_user
#
# Configures the root user's preferred prophile.
#
# === Parameters
#
# [*namevar*]
#   Name of the prophile to be applied to the root user.
#
# [*home*]
#   Path to root user's home directory.  Defaults to "/root".
#
# [*bash*]
#   Source URI of site-specific bash profile file.  If as an array, URIs will
#   be search in order listed.
#
# [*gvim*]
#   Source URI of site-specific gvim rc file.  If as an array, URIs will be
#   search in order listed.
#
# [*vim*]
#   Source URI of site-specific vim rc file.  If as an array, URIs will be
#   search in order listed.
#
# [*readline*]
#   Source URI of site-specific readline rc file.  If as an array, URIs will
#   be search in order listed.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


define prophile::root_user ($home='/root', $bash=undef, $gvim=undef,
        $vim=undef, $readline=undef) {

    exec { "prophile-install -f ${name}":
        environment => ["HOME=${home}"],
        require     => Class['prophile'],
        unless      => "grep -q prophile ${home}/.bash_profile",
    }

    prophile::site_config { "${home}/.bash_profile_site":
        source => $bash,
    }

    prophile::site_config { "${home}/.gvimrc_site":
        source => $gvim,
    }

    prophile::site_config { "${home}/.vimrc_site":
        source => $vim,
    }

    prophile::site_config { "${home}/.inputrc_site":
        source => $readline,
    }

}

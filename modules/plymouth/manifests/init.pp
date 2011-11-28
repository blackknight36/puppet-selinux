# modules/plymouth/manifests/init.pp

class plymouth {

    package { "plymouth":
        ensure  => installed,
    }

    package { "plymouth-scripts":
        ensure  => installed,
    }

    # Only configure the default plymouth theme if one has been specified.
    if "$plymouth_default_theme" != "" {
        exec { "set-plymouth-theme":
            # command returns 1 even when successful
            command => "plymouth-set-default-theme $plymouth_default_theme || true",
            unless  => "plymouth-set-default-theme | grep -q $plymouth_default_theme",
        }
    }

}

# modules/plymouth/manifests/init.pp
#
# Synopsis:
#       Configures plymouth on a host.
#
# Parameters:
#       $theme          Name of plymouth theme to show during boot process.
#                       Run 'plymouth-set-default-theme --list' on the host to
#                       see a list of possible choices.
#
# Example Usages:
#
#       To use the default plymouth theme:
#
#           class { 'plymouth': }
#
#       To use the details plymouth theme, which emulates classic Linux before
#       plymouth:
#
#           class { 'plymouth':
#               theme   => 'details',
#           }


class plymouth($theme='') {

    package { "plymouth":
        ensure  => installed,
    }

    package { "plymouth-scripts":
        ensure  => installed,
    }

    # Only alter plymouth's default theme if one has been specified.
    if "$theme" != "" {
        exec { "set-plymouth-theme":
            # command returns 1 even when successful
            command => "plymouth-set-default-theme $theme || true",
            unless  => "plymouth-set-default-theme | grep -q $theme",
        }
    }

}

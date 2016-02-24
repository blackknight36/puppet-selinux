# modules/xdg_desktop/manifests/params.pp
#
# == Class: xdg_desktop::params
#
# Parameters for the xdg_desktop puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class xdg_desktop::params {

    case $::operatingsystem {
        'Fedora': {

            $menu_command = 'xdg-desktop-menu'
            $app_dir = '/usr/local/share/applications'

        }

        default: {
            fail ("The xdg_desktop module is not yet supported on ${::operatingsystem}.")
        }

    }

}

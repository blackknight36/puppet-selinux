# modules/xdg_desktop/manifests/menu_entry.pp
#
# == Define: xdg_desktop::menu_entry
#
# Installs a desktop menu entry per the XDG Desktop Menu Specification.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the menu entry instance.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*dir_file*]
#   Path to the "directory file", which must already be deployed.  See
#   xdg-desktop-menu(1) for details.
#
# [*desktop_file*]
#   Path to the "desktop file", which must already be deployed.  See
#   xdg-desktop-menu(1) for details.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define xdg_desktop::menu_entry (
        $ensure='present',
        $dir_file,
        $desktop_file,
    ) {

    include 'xdg_desktop::params'

    case $ensure {

        'present': {
            exec { "install-xdg-menu-entry-${name}":
                command => "${xdg_desktop::params::menu_command} install ${dir_file} ${desktop_file}",
                creates => "${xdg_desktop::params::app_dir}/${name}.desktop",
            }
        }

        'absent': {
            exec { "uninstall-xdg-menu-entry-${name}":
                command => "${xdg_desktop::params::menu_command} uninstall ${dir_file} ${desktop_file}",
                onlyif  => "test -e \"${xdg_desktop::params::app_dir}/${name}.desktop\"",
            }
        }

        default: {
            fail('$ensure must be either "present" or "absent"')
        }

    }

}

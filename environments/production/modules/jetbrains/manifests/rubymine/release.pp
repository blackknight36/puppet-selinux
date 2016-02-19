# modules/jetbrains/manifests/rubymine/release.pp
#
# == Define: jetbrains::rubymine::release
#
# Installs a single, specific JetBrains RubyMine release.
#
# === Parameters
#
# [*namevar*]
#   The instance name.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*build*]
#   RubyMine build ID, e.g., '2.6' or '133.738'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define jetbrains::rubymine::release (
        $build, $ensure='present',
    ) {

    include 'jetbrains::params'
    include 'jetbrains::rubymine'

    $product_name = "rubymine-${build}"
    $product_root = "${jetbrains::params::rubymine_root}/${product_name}"
    $desktop_file = "${jetbrains::rubymine::launchers_path}/${product_name}.desktop"

    file { $desktop_file:
        ensure  => $ensure,
        content => template('jetbrains/rubymine/build.desktop'),
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        require => File[$jetbrains::rubymine::launchers_path],
        selrole => 'object_r',
        seltype => 'usr_t',
        seluser => 'system_u',
    }

    xdg_desktop::menu_entry { $product_name:
        ensure       => $ensure,
        dir_file     => $jetbrains::jetbrains_menu,
        desktop_file => $desktop_file,
        require      => [
            Class['jetbrains'],
            File[$desktop_file],
        ],
    }

    case $ensure {

        'present': {
            exec { "extract-${product_name}":
                command => "tar xz --transform='s!^[^/]*!${product_name}!' -f /pub/jetbrains/RubyMine-${build}.tar.gz",
                creates => $product_root,
                cwd     => $jetbrains::params::rubymine_root,
                require => [
                    Class['autofs'],
                    File[$jetbrains::params::rubymine_root],
                ],
            }
        }

        'absent': {
            file { $product_root:
                ensure  => 'absent',
                force   => true,
                recurse => true,
            }
        }

        default: {
            fail('$ensure must be either "present" or "absent"')
        }

    }

}

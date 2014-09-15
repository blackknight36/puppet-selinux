# modules/jetbrains/manifests/idea/release.pp
#
# == Define: jetbrains::idea::release
#
# Installs a single, specific JetBrains IDEA release.
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
#   IDEA build ID, e.g., '111.277'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define jetbrains::idea::release ($build, $ensure='present') {

    include 'jetbrains::params'

    $product_name = "idea-IU-${build}"
    $product_root = "${jetbrains::params::idea_root}/${product_name}"
    $desktop_file = "${jetbrains::idea::launchers_path}/${name}.desktop"

    file { $desktop_file:
        ensure  => $ensure,
        content => template('jetbrains/idea/build.desktop'),
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        require => File[$jetbrains::idea::launchers_path],
        selrole => 'object_r',
        seltype => 'usr_t',
        seluser => 'system_u',
    }

    xdg_desktop::menu_entry { $name:
        ensure          => $ensure,
        dir_file        => $jetbrains::jetbrains_menu,
        desktop_file    => $desktop_file,
        require         => [
            Class['jetbrains'],
            File[$desktop_file],
        ],
    }

    case $ensure {

        'present': {
            exec { "extract-${name}":
                command => "tar xzf /pub/jetbrains/${name}.tar.gz",
                creates => $product_root,
                cwd     => $jetbrains::params::idea_root,
                require => [
                    Class['autofs'],
                    File[$jetbrains::params::idea_root],
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

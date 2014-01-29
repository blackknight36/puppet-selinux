# modules/jetbrains/manifests/pycharm_release.pp
#
# == Define: jetbrains::pycharm_release
#
# Installs a single, specific JetBrains PyCharm release.
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
#   PyCharm build ID, e.g., '2.6' or '133.738'.
#
# [*edition*]
#   One of: 'community', 'professional' or 'legacy' (default).  'legacy' is
#   only appropriate for releases/builds prior to the introduction of the
#   professional/community editions, i.e., 3.0.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define jetbrains::pycharm_release (
        $build, $ensure='present', $edition='legacy'
    ) {

    include 'jetbrains::params'

    case $edition {
        'community': {
            $install_tag = '-community'
            $package_tag = '-community'
        }
        'professional': {
            $install_tag = ''
            $package_tag = '-professional'
        }
        default: {
            $install_tag = ''
            $package_tag = ''
        }
    }

    $product_name = "pycharm${install_tag}-${build}"
    $product_root = "${jetbrains::params::pycharm_root}/${product_name}"

    file { "${jetbrains::pycharm::launchers_path}/${product_name}.desktop":
        content => template('jetbrains/pycharm/build.desktop'),
        ensure  => "${ensure}",
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        require => File["${jetbrains::pycharm::launchers_path}"],
        selrole => 'object_r',
        seltype => 'usr_t',
        seluser => 'system_u',
    }

    case $ensure {

        'present': {
            exec { "extract-${product_name}":
                command => "tar xz --transform='s!^[^/]*!${product_name}!' -f /pub/jetbrains/pycharm${package_tag}-${build}.tar.gz",
                creates => "${product_root}",
                cwd     => "${jetbrains::params::pycharm_root}",
                require => [
                    Class['autofs'],
                    File["${jetbrains::params::pycharm_root}"],
                ],
            }
        }

        'absent': {
            file { "${product_root}":
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

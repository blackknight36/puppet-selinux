# modules/jetbrains/manifests/pycharm_release.pp
#
# Synopsis:
#       Installs a single, specific JetBrains PyCharm release.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
#       build                   PyCharm build ID, e.g. '2.6'
#
# Notes:
#
#       1. Default is 'present'.


define jetbrains::pycharm_release ($build, $ensure='present') {

    include 'jetbrains::params'

    $product_name = "pycharm-${build}"
    $product_root = "${jetbrains::params::pycharm_root}/${product_name}"

    file { "${jetbrains::pycharm::launchers_path}/${name}.desktop":
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
            exec { "extract-${name}":
                command => "tar xzf /pub/jetbrains/pycharm-${build}.tar.gz",
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
            fail('$ensure must be either "present" or "absent".')
        }

    }

}

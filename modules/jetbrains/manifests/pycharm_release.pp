# modules/jetbrains/manifests/pycharm_release.pp
#
# Synopsis:
#       Installs a single, specific JetBrains PyCharm release.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            instance name
#       build                           JetBrains build ID, e.g. '2.6'
#       ensure          present         instance is to be present/absent
#
# Requires:
#       Class['jetbrains::pycharm']
#
# Example Usage:
#
#       include jetbrains::pycharm
#
#       jetbrains::pycharm_release { 'latest':
#           build   => '2.6',
#       }


define jetbrains::pycharm_release ($build, $ensure='present') {

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
            exec { "extract-${name}-pycharm":
                command => "tar xzf /pub/jetbrains/${name}.tar.gz",
                creates => "${jetbrains::pycharm::root}/pycharm-${build}",
                cwd     => "${jetbrains::pycharm::root}",
                require => [
                    Class['autofs'],
                    File["${jetbrains::pycharm::root}"],
                ],
            }
        }

        'absent': {
            file { "${jetbrains::pycharm::root}/pycharm-${build}":
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

# modules/jetbrains/manifests/idea-release.pp
#
# Synopsis:
#       Installs a idea-release configuration file for jetbrains.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            instance name
#       build                           JetBrains build ID, e.g. '111.277'
#       ensure          present         instance is to be present/absent
#
# Requires:
#       Class['jetbrains::idea']
#
# Example usage:
#
#       include jetbrains::idea
#
#       jetbrains::idea-release { 'latest':
#           build   => "114.98",
#       }
#
#       jetbrains::idea-release { 'ancient':
#           build   => "1.23",
#           ensure  => absent,
#       }


define jetbrains::idea-release ($build, $ensure='present') {

    file { "${jetbrains::idea::launchers_path}/${name}.desktop":
        content => template("jetbrains/idea/build.desktop"),
        ensure  => "${ensure}",
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        require => File["${jetbrains::idea::launchers_path}"],
        selrole => 'object_r',
        seltype => 'usr_t',
        seluser => 'system_u',
    }

    case $ensure {

        'present': {
            exec { "extract-${name}-idea":
                command => "tar xzf /pub/jetbrains/${name}.tar.gz",
                creates => "${jetbrains::idea::root}/idea-IU-${build}",
                cwd     => "${jetbrains::idea::root}",
                require => [
                    Class['autofs'],
                    File["${jetbrains::idea::root}"],
                ],
            }
        }

        'absent': {
            file { "${jetbrains::idea::root}/idea-IU-${build}":
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

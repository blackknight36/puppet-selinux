# modules/jetbrains/manifests/definitions/idea-release.pp
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
#           release => "114.98",
#           build   => "114.98",
#       }


define jetbrains::idea-release ($build) {

    file { "${idea_launchers}/${name}.desktop":
        content => template("jetbrains/idea/build.desktop"),
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        require => File["${idea_launchers}"],
        selrole => 'object_r',
        seltype => 'usr_t',
        seluser => 'system_u',
    }

    exec { "extract-${name}-idea":
        command => "tar xzf /pub/jetbrains/${name}.tar.gz",
        creates => "${idea_root}/idea-IU-${build}",
        cwd     => "${idea_root}",
        require => [
            Class['autofs'],
            File["${idea_root}"],
        ],
    }

}

# modules/jetbrains/manifests/teamcity/agent_release.pp
#
# Synopsis:
#       Installs a single, specific JetBrains TeamCity release Build Agent.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       build                   TeamCity build ID, e.g. '3.0.8'
#
#       ensure          1       instance is to be present/absent
#
#       active          2       instance is to be enabled/running
#
# Notes:
#
#       1. Default is 'present'.
#
#       2. Default is true.


define jetbrains::teamcity::agent_release (
        $build, $ensure='present', $active=true
    ) {

    include 'jetbrains::params'
    include 'jetbrains::teamcity::agent'

    $product_name = "teamcity-agent-${build}"
    $product_root = "${jetbrains::params::teamcity_root}/${product_name}"

    case $ensure {

        'present': {
            exec { "extract-${product_name}":
                # Notes:
                #   1. Transform top-level directory name of extraction so
                #   that it conforms with other JetBrain's products and so
                #   that it's possible to have multiple releases installed, if
                #   needed.
                #   2. Only extract the Build Agent that is bundled and
                #   distributed with the Server package.  The
                #   jetbrains::teamcity::server_release class excludes this
                #   portion so that the puppet portions can remain modular in
                #   a pure sense.
                command => "tar xz --transform='s!^TeamCity/buildAgent!${product_name}!' -f /pub/jetbrains/TeamCity-${build}.tar.gz TeamCity/buildAgent/",
                creates => "${product_root}",
                cwd     => "${jetbrains::params::teamcity_root}",
                user    => 'teamcity',
                group   => 'teamcity',
                require => [
                    Class['autofs'],
                    Class['jetbrains::teamcity::agent'],
                ],
                before  => Systemd::Unit["${product_name}.service"],
            }

        }

        'absent': {
            file { "${product_root}/buildAgent":
                ensure  => 'absent',
                force   => true,
                recurse => true,
                after   => Systemd::Unit["${product_name}.service"],
            }
        }

        default: {
            fail('$ensure must be either "present" or "absent".')
        }

    }

    systemd::unit { "${product_name}.service":
        content         => template('jetbrains/teamcity/teamcity-agent.service'),
        ensure          => $ensure,
        enable          => $active,
        running         => $active,
        restart_events  => File["${jetbrains::params::teamcity_rc}"],
    }

}

# modules/jetbrains/manifests/teamcity/agent_release.pp
#
# == Define: jetbrains::teamcity::agent_release
#
# Installs a single, specific JetBrains TeamCity Build Agent release.
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
#   TeamCity build ID, e.g., '3.0.8'.
#
# [*active*]
#   When true (default), instance is to be enabled and running.  Otherwise
#   instance is to be disabled and stopped.
#
# [*server_url*]
#   URL were TeamCity Server may be reached.  Default is
#   'http://localhost:8111/', which is only appropriate for the "bundled"
#   authorized Agent that "comes with" the Server.  The TeamCity package has
#   both Agent and Server bundled together for the Server installation, but
#   the Puppet manifests isolate the two for better modularity whilst still
#   allowing the typical integrated setup of the Server.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define jetbrains::teamcity::agent_release (
        $build, $ensure='present', $active=true,
        $server_url='http://localhost:8111/'
    ) {

    include 'jetbrains::params'
    include 'jetbrains::teamcity::agent'

    $product_name = "teamcity-agent-${build}"
    $product_root = "${jetbrains::params::teamcity_root}/${product_name}"
    $product_props = "${product_root}/conf/buildAgent.properties"

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

            Jetbrains::Teamcity::Agent_property {
                props_file  => "${product_props}",
                before      => Systemd::Unit["${product_name}.service"],
                require     => Exec["extract-${product_name}"],
            }

            jetbrains::teamcity::agent_property { 'name':
                value       =>  "${hostname}",
            }

            jetbrains::teamcity::agent_property { 'serverUrl':
                value       =>  "${server_url}",
            }

        }

        'absent': {
            file { "${product_root}/buildAgent":
                ensure  => 'absent',
                force   => true,
                recurse => true,
                require => Systemd::Unit["${product_name}.service"],
            }
        }

        default: {
            fail('$ensure must be either "present" or "absent"')
        }

    }

    systemd::unit { "${product_name}.service":
        content         => template('jetbrains/teamcity/teamcity-agent.service'),
        ensure          => $ensure,
        enable          => $active,
        running         => $active,
        restart_events  => [
            File["${jetbrains::params::teamcity_rc}"],
            Jetbrains::Teamcity::Agent_property['name'],
            Jetbrains::Teamcity::Agent_property['serverUrl'],
        ],
    }

}

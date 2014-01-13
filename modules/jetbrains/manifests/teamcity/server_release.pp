# modules/jetbrains/manifests/teamcity/server_release.pp
#
# == Define: jetbrains::teamcity::server_release
#
# Installs a single, specific JetBrains TeamCity Server release.
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
# === Authors
#
#   John Florian <john.florian@dart.biz>


define jetbrains::teamcity::server_release (
        $build, $ensure='present', $active=true
    ) {

    include 'jetbrains::params'
    include 'jetbrains::teamcity::server'

    $product_name = "teamcity-server-${build}"
    $product_root = "${jetbrains::params::teamcity_root}/${product_name}"

    case $ensure {

        'present': {
            exec { "extract-${product_name}":
                # Notes:
                #   1. Transform top-level directory name of extraction so
                #   that it conforms with other JetBrain's products and so
                #   that it's possible to have multiple releases installed, if
                #   needed.
                #   2. Exclude the Build Agent that is bundled and distributed
                #   with the Server package.  The
                #   jetbrains::teamcity::agent_release class extract that
                #   portion separately so that the puppet portions can remain
                #   modular in a pure sense.
                command => "tar xz --transform='s!^TeamCity!${product_name}!' --exclude=TeamCity/buildAgent -f /pub/jetbrains/TeamCity-${build}.tar.gz",
                creates => "${product_root}",
                cwd     => "${jetbrains::params::teamcity_root}",
                user    => 'teamcity',
                group   => 'teamcity',
                require => [
                    Class['autofs'],
                    Class['jetbrains::teamcity::server'],
                ],
                before  => Systemd::Unit["${product_name}.service"],
            }

        }

        'absent': {
            file { "${product_root}":
                ensure  => 'absent',
                force   => true,
                recurse => true,
                after   => Systemd::Unit["${product_name}.service"],
            }
        }

        default: {
            fail('$ensure must be either "present" or "absent"')
        }

    }

    systemd::unit { "${product_name}.service":
        content         => template('jetbrains/teamcity/teamcity-server.service'),
        ensure          => $ensure,
        enable          => $active,
        running         => $active,
        restart_events  => File["${jetbrains::params::teamcity_rc}"],
    }

}

# modules/jetbrains/manifests/teamcity_release.pp
#
# Synopsis:
#       Installs a single, specific JetBrains TeamCity Server release.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
#       build                   TeamCity build ID, e.g. '3.0.8'
#
# Notes:
#
#       1. Default is 'present'.


define jetbrains::teamcity_release ($ensure='present', $build) {

    include 'jetbrains::params'
    include 'jetbrains::teamcity'

    $product_name = "teamcity-${build}"
    $product_root = "${jetbrains::params::teamcity_root}/${product_name}"

    case $ensure {

        'present': {
            exec { "extract-${name}":
                # NB: Transform top-level directory name of extraction so that
                # it conforms with othed JetBrain's products and so that it's
                # possible to have multiple releases installed, if needed.
                command => "tar xz --transform='s/^TeamCity/${product_name}/' -f /pub/jetbrains/TeamCity-${build}.tar.gz",
                creates => "${product_root}",
                cwd     => "${jetbrains::params::teamcity_root}",
                user    => 'teamcity',
                group   => 'teamcity',
                require => [
                    Class['autofs'],
                    Class['jetbrains::teamcity'],
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

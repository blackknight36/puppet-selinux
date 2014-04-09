# modules/dart/manifests/abstract/teamcity_server_node.pp
#
# Synopsis:
#       Typical TeamCity Server for Dart use.


class dart::abstract::teamcity_server_node inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'
    include 'dart::subsys::yum_cron'

    oracle::jdk { 'for TeamCity Server':
        ensure  => 'present',
        version => '7',
        update  => '51',
        # Oracle's architecture labeling is non-standard; so we adapt here.
        arch    => $architecture ? {
            'i386'      => 'i586',
            'x86_64'    => 'x64',
        },
    }

    include 'packages::developer'
    include 'puppet::client'

    # This package allows optimal performance in production environments.
    package { 'tomcat-native':
        ensure  => installed,
    }

    case $hostname {
        'mdct-est-ci': {
            jetbrains::teamcity::server_release { 'TeamCity-7.1':
                build   => '7.1',
            }
        }
        'mdct-teamcity-f20': {
            jetbrains::teamcity::server_release { 'TeamCity-8.1.2':
                build   => '8.1.2',
            }
        }
    }

}

# modules/dart/manifests/abstract/teamcity_agent_node.pp
#
# == Class: dart::abstract::teamcity_agent_node
#
# Configures a host as a typical TeamCity Agent for Dart use.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::teamcity_agent_node inherits dart::abstract::guarded_server_node {

    include 'dart::abstract::packages::developer'
    include 'dart::abstract::teamcity_agent_node_est_ngic'
    include 'dart::subsys::autofs::common'
    include 'dart::subsys::yum_cron'
    include 'lyx'
    include 'puppet::client'

    case $::hostname {
        'mdct-est-ci': {
            jetbrains::teamcity::agent::release { 'TeamCity-7.1':
                build   => '7.1',
            }
        }
        /^mdct-teamcity-agent.*$/: {
            include 'openjdk::java_1_7_0'

            jetbrains::teamcity::agent::release { 'TeamCity-8.1.4':
                build       => '8.1.4',
                server_url  => 'http://mdct-teamcity-f20.dartcontainer.com:8111/',
            }

            jetbrains::teamcity::agent::release { 'TeamCity-8.1.2':
                ensure      => absent,
                build       => '8.1.2',
                server_url  => 'http://mdct-teamcity-f20.dartcontainer.com:8111/',
            }

        }
        default: {
            fail('Missing host-specific details!')
        }
    }

    mock::target { 'Fedora-18-i386':
        family              => 'fedora',
        release             => '18',
        target_arch         => 'i686',
        base_arch           => 'i386',
        legal_host_arches   => ['i386', 'i586', 'i686', 'x86_64'],
    }

    mock::target { 'Fedora-18-x86_64':
        family              => 'fedora',
        release             => '18',
        target_arch         => 'x86_64',
        base_arch           => 'x86_64',
        legal_host_arches   => ['x86_64'],
    }

    mock::target { 'Fedora-19-i386':
        family              => 'fedora',
        release             => '19',
        target_arch         => 'i686',
        base_arch           => 'i386',
        legal_host_arches   => ['i386', 'i586', 'i686', 'x86_64'],
    }

    mock::target { 'Fedora-19-x86_64':
        family              => 'fedora',
        release             => '19',
        target_arch         => 'x86_64',
        base_arch           => 'x86_64',
        legal_host_arches   => ['x86_64'],
    }

    mock::target { 'Fedora-20-i386':
        family              => 'fedora',
        release             => '20',
        target_arch         => 'i686',
        base_arch           => 'i386',
        legal_host_arches   => ['i386', 'i586', 'i686', 'x86_64'],
    }

    mock::target { 'Fedora-20-x86_64':
        family              => 'fedora',
        release             => '20',
        target_arch         => 'x86_64',
        base_arch           => 'x86_64',
        legal_host_arches   => ['x86_64'],
    }

    mock::user {
        'teamcity':;
        'd13677':;
    }

}

# modules/dart/manifests/abstract/teamcity_server_node.pp
#
# == Class: dart::abstract::teamcity_server_node
#
# Configures a host as a typical TeamCity Server for Dart use.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::teamcity_server_node inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'
    include 'dart::subsys::yum_cron'
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
            include 'openjdk::java_1_7_0'

            $production = '8.1.2'

            jetbrains::teamcity::server_release { "TeamCity-${production}":
                build   => "${production}",
            }

            jetbrains::teamcity::server_release { 'TeamCity-8.1a':
                ensure  => absent,
                build   => '8.1a',
            }

            # TeamCity relies on a manually installed postgresql-jdbc driver
            # in /opt/jetbrains/teamcity/.BuildServer/lib/jdbc/ that was
            # downloaded from http://jdbc.postgresql.org/download.html
            #
            # I didn't make puppet manage this since it resides in TeamCity's
            # Data directory.  Installing the postgresql-jdbc package from
            # Fedora didn't work and it seems too old according to the driver
            # web page which states JDK 1.7 should use the "JDBC41" driver.
            class { 'postgresql::server':
                hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
                before      => Jetbrains::Teamcity::Server_release["TeamCity-${production}"],
            }

        }
    }

}

# modules/openjdk/manifests/java_1_7_0.pp
#
# == Class: openjdk::java_1_7_0
#
# Configures a host with the OpenJDK runtime environment, version 1.7.0.
#
# This class exists without parameters and not as a definition so that it may
# be included multiple times for a given host.  This permits this class to be
# included in applications classes that require it, even if several such
# applications are provisioned on a host.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class openjdk::java_1_7_0 {

    include 'openjdk::params'

    package { $openjdk::params::packages_1_7_0:
        ensure  => installed,
    }

}

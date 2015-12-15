# modules/dart/manifests/abstract/teamcity_agent_node_est_ngic.pp
#
# == Class: dart::abstract::teamcity_agent_node_est_ngic
#
# Configures a host as a typical TeamCity Agent for Dart use with resepect to
# special requirements needed for building EST and/or NGIC.  This class is
# a temporary kludge until the offending hardcoded paths are eliminated.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::teamcity_agent_node_est_ngic {

    file { [
                '/home/est',
                '/home/est/lucene',
                '/home/est/lucene/indexes',
                '/home/ngic',
                '/home/ngic/lucene',
                '/home/ngic/lucene/indexes',
        ]:
        ensure => directory,
        owner  => 'teamcity',
        group  => 'teamcity',
        mode   => '0755',
    }

    class { 'postgresql::server':
        ipv4acls    => [
                        'host    est_junit       est_junit       samehost                trust',
                        'host    all             all             samehost                md5',
        ],
    }

    postgresql::server::db { 'est_junit':
        user     => 'est_junit',
        password => postgresql_password('est_junit', 'est_junit'),
    }

    postgresql::server::db { 'tcir_junit':
        user     => 'tcir_junit',
        password => postgresql_password('tcir_junit', 'tcir_junit'),
    }

    postgresql::server::db { 'cats_junit':
        user     => 'cats_junit',
        password => postgresql_password('cats_junit', 'cats_junit'),
    }

    # NB: TeamCity itself uses the OpenJDK.
    oracle::jdk { 'jdk-8-linux-x64':
        ensure  => 'present',
        version => '8',
        update  => '',
    }

}

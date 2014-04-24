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

    file { [ '/home/est', '/home/est/lucene', '/home/est/lucene/indexes',
             '/home/ngic', '/home/ngic/lucene', '/home/ngic/lucene/indexes',
           ]:
        ensure  => directory,
        owner   => 'teamcity',
        group   => 'teamcity',
        mode    => '0755',
    }

}

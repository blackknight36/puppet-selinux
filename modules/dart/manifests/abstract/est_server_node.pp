# modules/dart/manifests/abstract/est_server_node.pp

class dart::abstract::est_server_node inherits dart::abstract::tomcat_web_app {

    package { [ 'postgresql.x86_64', 'postgresql-contrib.x86_64', 'postgresql-jdbc.noarch', 'postgresql-libs.x86_64', 'postgresql-server.x86_64', ]:
        ensure  => installed,
    }

    group { 'estindexers':
        ensure => present,
    }

    user { 'est':
        groups => ['estindexers'],
    }

#    user { 'tomcat':
#        ensure => role,
#        groups => ['estindexers'],
#    }
}

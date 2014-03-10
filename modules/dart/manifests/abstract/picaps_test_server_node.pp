# modules/dart/manifests/abstract/picaps_test_server_node.pp
#
# Synopsis:
#       This class is to be used primarily for servers that are used for
#       testing PICAPS through various stages of deployment at a plant.

class dart::abstract::picaps_test_server_node inherits dart::abstract::unguarded_server_node {

    include 'dart::subsys::autofs::common'
    include 'dart::subsys::picaps::apache'

    # Other packages required by PICAPS servers
    if $::operatingsystem == 'Fedora' and $::operatingsystemrelease >= 20 {
        $python_mx = 'python-egenix-mx-base'
    } else {
        $python_mx = 'mx'
    }
    package { [
        'numactl',
        'numad',
        'cups',
        'ncftp',
        'pyserial',
        'setserial',
        $python_mx,
        ]:
        ensure  => 'installed',
    }

    class { 'puppet::client':
    }

    sendmail::alias { 'root':
        recipient   => 'nathan.nephew@dart.biz',
    }

    # PICAPS uses rsync for backup and other similar uses
    #   class { 'rsync::server':
    #       source  => 'puppet:///modules/dart/picaps_servers/rsyncd/rsyncd.conf',
    #   }

    # Samba
    include 'samba'

    # Developer tools (includes python, cvs, git, etc)
    include 'packages::developer'

    # JDK's
    oracle::jdk { 'jdk-7u25-linux-x64':
        ensure  => 'present',
        version => '7',
        update  => '25',
    }
    oracle::jdk { 'jdk-7u21-linux-x64':
        ensure  => 'present',
        version => '7',
        update  => '21',
        before  => [
            Exec["install oracle jdk-7u25-linux-x64"],
        ],
    }
    file { "/usr/java/latest/jre/lib/management/jmxremote.password":
        group   => "root",
        mode    => 600,
        owner   => "root",
        source  => [
            'puppet:///modules/dart/picaps_servers/jmxremote.password',
        ],
        require  => [
            Exec["install oracle jdk-7u25-linux-x64"],
        ],
    }

    # Printing support
    file { "/etc/cups/cupsd.conf":
        group   => "lp",
        mode    => 640,
        owner   => "root",
        source  => [
            'puppet:///modules/dart/picaps_servers/picaps-cupsd.conf',
        ],
    }
    file { "/root/picaps-printer-setup.sh":
        group   => "root",
        mode    => 755,
        owner   => "root",
        source  => [
            'puppet:///modules/dart/picaps_servers/picaps-printer-setup.sh',
        ],
    }

    # PICAPS database
    class { 'mariadb::server':
        config_uri => 'puppet:///modules/dart/picaps_servers/picaps-test-mariadb-server.cnf',
    }
    file { "/etc/systemd/system/mysqld.service":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source  => 'puppet:///modules/dart/picaps_servers/picaps-mysqld.service',
        before  => File['/storage/mysql'],
    }
    file { '/storage/':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
    ensure      => 'directory',
    before      => File['/storage/mysql'],
    }
    file { '/storage/mysql':
        owner   => 'mysql',
        group   => 'mysql',
        mode    => '0755',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'mysqld_db_t',
        ensure  => 'directory',
        before  => Class['mariadb::server'],
    }
    user { 'mysql':
        provider    => 'useradd',
        uid         => 444,
        gid         => 444,
        home        => '/storage/mysql',
        system      => true,
        before      => File['/etc/systemd/system/mysqld.service'],
    }
    group { 'mysql':
       provider => 'groupadd',
       gid      => 444,
       system   => true,
       before   => User['mysql'],
    }

    file { "/root/picaps-grant.sql":
        group   => "root",
        mode    => 660,
        owner   => "root",
        content => template('dart/picaps/picaps-grant.sql'),
    }
    file { "/root/picaps-databases.sql":
        group   => "root",
        mode    => 660,
        owner   => "root",
        source  => 'puppet:///modules/dart/picaps_servers/picaps-databases.sql',
    }
    file { "/root/picaps-install.sh":
        group   => "root",
        mode    => 770,
        owner   => "root",
        source  => 'puppet:///modules/dart/picaps_servers/picaps-install.sh',
    }
    file { "/root/picaps-initdb.sh":
        group   => "root",
        mode    => 770,
        owner   => "root",
        source  => 'puppet:///modules/dart/picaps_servers/picaps-initdb.sh',
    }
    file { "/root/picaps-test-initdb.sh":
        group   => "root",
        mode    => 770,
        owner   => "root",
        source  => 'puppet:///modules/dart/picaps_servers/picaps-test-initdb.sh',
    }

    # PICAPS Software
    # NOTE: open a console on the server as root, execute picaps-install.sh, edit /etc/sysconfig/picaps and execute picaps-initdb.sh
    # NOTE: systemctl enable picaps.service
    #
    # TODO: PICAPS-server package
    # TODO: PICAPS package
    # TODO: PICAPS-bridge package

    # PICAPS calls gethostbyname() for its own hostname which must resolve.
    #
    # NB: If you get the following error from puppet here ...
    #   Parameter ip failed: Invalid IP address ""
    # ... it is most likely due to this bug ...
    #   https://projects.puppetlabs.com/issues/15001
    # As a work around, you should either: 1) put the host into DNS or, 2) put
    # the host into /etc/hosts (manually, of course).
    host { "$fqdn":
        ip              => "$ipaddress",
        host_aliases    => [ "$hostname" ],
    }

}

# modules/dart/manifests/abstract/picaps_production_server_node.pp
#
# Synopsis:
#       This class is to be used for PICAPS production servers only.

class dart::abstract::picaps_production_server_node inherits dart::abstract::server_node {

    # Other packages required by PICAPS servers
    package { [
        'numactl',
        'numad',
        'httpd',
        'cups',
        'ncftp',
        'pyserial',
        ]:
        ensure  => 'installed',
    }

    # Disable iptables
    class { 'iptables':
        enabled => false,
    }

    # PICAPS admins desire puppet only for tasks at server inception and forgo
    # all run-state management.
    class { 'puppet::client':
        enable  => false,
        ensure  => 'stopped',
    }

    mailalias { "root":
        ensure          => present,
        recipient       => "chris.kennedy@dart.biz",
    }

    # Disable selinux
    # Note: switching from enforcing or permissive to disabled requires reboot.
    # Note: switching from disabled to enforcing or permissive requires reboot.
    class { 'selinux':
        mode => 'disabled',
    }

    # OpenIPMI
    include 'ipmi'

    # Automatic package updates
    #include 'yum-cron'

    # PICAPS uses rsync for backup and other similar uses
    include 'rsync-server'

    # Samba
    include 'samba'

    # Developer tools (includes python, cvs, git, etc)
    include 'packages::developer'

    # Printing support
    # TODO: something

    # JDK's
    oracle::jdk { 'jdk-7u21-linux-x64':
        ensure  => 'present',
        version => '7',
        update  => '21',
    }
    oracle::jdk { 'jdk-7u17-linux-x64':
        ensure  => 'present',
        version => '7',
        update  => '17',
        before  => [
            Exec["install oracle jdk-7u21-linux-x64"],
        ],
    }
    file { "/usr/java/latest/jre/lib/management/jmxremote.password":
        group   => "root",
        mode    => 600,
        owner   => "root",
        source  => [
            'puppet:///modules/dart/picaps-servers/jmxremote.password',
        ],
        require  => [
            Exec["install oracle jdk-7u21-linux-x64"],
        ],
    }

    # PICAPS Web Server Redirection
    user { 'apache':
        provider => 'useradd',
        uid    => 48,
        gid    => 48,
        home   => '/var/www',
        system => true,
        before => Package['httpd'],
    }
    group { 'apache':
       provider => 'groupadd',
       gid      => 48,
       system   => true,
       before   => User['apache'],
    }
    file { "/var/www/html/index.html":
        group   => "root",
        mode    => 644,
        owner   => "root",
        content  => template('dart/picaps/index.html'),
        require		=> [
            Package["httpd"],
        ],
    }
    file { "/var/www/cgi-bin/checkWeb.cgi":
        group   => "root",
        mode    => 755,
        owner   => "root",
        content  => template('dart/picaps/checkWeb.cgi'),
        require		=> [
            Package["httpd"],
        ],
    }
    #file { "/etc/httpd/conf.d/ssl.conf":
    #    group   => "root",
    #    mode    => 644,
    #    owner   => "root",
    #    source  => [
    #        'puppet:///modules/dart/picaps-servers/picaps-httpd-ssl.conf',
    #    ],
    #}
    service { "httpd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["httpd"],
            File ["/var/www/html/index.html"],
            File ["/var/www/cgi-bin/checkWeb.cgi"],
        ],
    }

    # PICAPS database
    class { 'mariadb::server':
        config_uri => 'puppet:///modules/dart/picaps-servers/picaps-mariadb-server.cnf',
    }
    file { "/etc/systemd/system/mysqld.service":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source  => 'puppet:///modules/dart/picaps-servers/picaps-mysqld.service',
        before => File['/storage/mysql'],
    }
    file { '/storage/mysql':
        owner       => 'mysql',
        group       => 'mysql',
        mode        => '0755',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'mysqld_db_t',
	ensure      => 'directory',
	before      => Class['mariadb::server'],
    }
    user { 'mysql':
        provider => 'useradd',
        uid    => 444,
        gid    => 444,
        home   => '/storage/mysql',
        system => true,
        before => File['/etc/systemd/system/mysqld.service'],
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
        content  => template('dart/picaps/picaps-grant.sql'),
    }
    file { "/root/picaps-databases.sql":
        group   => "root",
        mode    => 660,
        owner   => "root",
        source  => 'puppet:///modules/dart/picaps-servers/picaps-databases.sql',
    }
    file { "/root/picaps-install.sh":
        group   => "root",
        mode    => 770,
        owner   => "root",
        source  => 'puppet:///modules/dart/picaps-servers/picaps-install.sh',
    }
    file { "/root/picaps-initdb.sh":
        group   => "root",
        mode    => 770,
        owner   => "root",
        source  => 'puppet:///modules/dart/picaps-servers/picaps-initdb.sh',
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

# modules/dart/manifests/mdct-pt-dbtest.pp
#
# Synopsis:
#       This class is used primarily for a PICAPS test server specific to database testing

class dart::mdct-pt-dbtest inherits dart::abstract::server_node {

    # Declare the source of the JDK to be installed.
    $jdk_rpm_source='http://mdct-00fs.dartcontainer.com/ftp/pub/oracle/jdk-7u10-linux-x64.rpm'

    # Declare the JDK that PICAPS is to use.
    $picaps_jdk='/usr/java/jdk1.7.0_10'

    # Could be enabled, but need a list of ports to be opened.  Traditional
    # PICAPS servers just have it disabled however.
    class { 'iptables':
        enabled => false,
    }

    # Enable automatic package updates
    include 'yum-cron'

    # PICAPS uses rsync for backup and other similar uses
    include 'rsync-server'

    # Samba may be useful for some adminstrators
    include 'samba'

    # PICAPS installation is via cvs
    include 'packages::developer'

    # PICAPS stores are via MySQL
    #include 'mysql-server' --DISABLED SINCE THIS INSTANCE IS FOR TESTING OTHER RDBMS

    # Other package a PICAPS server requires
    package { [

        'httpd',
        'ncftp',
        'pyserial',

        ]:
        ensure  => 'installed',
    }

    # SEE NO-DNS-HOSTS
    # PICAPS calls gethostbyname() for its own hostname which must resolve.
    #host { "$fqdn":
    #    ip              => "$ipaddress",
    #    host_aliases    => [ "$hostname" ],
    #}

    file { '/usr/local/bin/picaps-install-and-setup':
        content => template('dart/picaps/install-and-setup'),
        group   => 'root',
        mode    => '0754',
        owner   => 'root',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'file_t',
    }

    exec { '/usr/local/bin/picaps-install-and-setup':
        creates => '/root/picaps-install-and-setup.log',
        require => [
            #Class['mysql-server'],
            Class['packages::developer'],
            Class['rsync-server'],
            File['/usr/local/bin/picaps-install-and-setup'],
            Package['httpd'],
            Package['ncftp'],
        ],
        timeout => 1800,
    }

}

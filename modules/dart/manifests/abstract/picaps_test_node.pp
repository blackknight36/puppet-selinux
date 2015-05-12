# modules/dart/manifests/abstract/picaps_test_node.pp
#
# Synopsis:
#       This class is used primarily for servers that are used for testing
#       PICAPS through various stages of deployment at a plant.

class dart::abstract::picaps_test_node inherits dart::abstract::unguarded_server_node {

    include 'dart::subsys::autofs::common'

    # Declare the source of the JDK to be installed.
    $jdk_rpm_source='http://mdct-00fs.dartcontainer.com/pub/oracle/jdk-7u5-linux-x64.rpm'

    # Declare the JDK that PICAPS is to use.
    $picaps_jdk='/usr/java/jdk1.7.0_05'

    # Enable automatic package updates
    include 'dart::subsys::yum_cron'

    # PICAPS uses rsync for backup and other similar uses
    class { 'rsync::server':
        source  => 'puppet:///modules/dart/picaps_servers/rsyncd/rsyncd.conf',
    }

    # Samba may be useful for some adminstrators
    include 'samba'

    # PICAPS installation is via cvs
    include 'dart::abstract::packages::developer'

    # PICAPS stores are via MySQL


    case $hostname {
        'mdct-04pt', 'mdct-55pt': {
            $dbserver = 'mariadb_server_pref18'
        }

        default: {
            $dbserver = 'mysql-server'
        }

    }
    include $dbserver


    # Other package a PICAPS server requires
    package { [

        'httpd',
        'ncftp',
        'pyserial',

        ]:
        ensure  => 'installed',
    }

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

    file { '/usr/local/bin/picaps-install-and-setup':
        content => template('dart/picaps/install-and-setup'),
        group   => 'root',
        mode    => '0754',
        owner   => 'root',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'file_t',
    }

    #exec { '/usr/local/bin/picaps-install-and-setup':
    #    creates => '/root/picaps-install-and-setup.log',
    #    require => [
    #        Class[$dbserver],
    #        Class['packages::developer'],
    #        Class['rsync::server'],
    #        File['/usr/local/bin/picaps-install-and-setup'],
    #        Package['httpd'],
    #        Package['ncftp'],
    #    ],
    #    timeout => 1800,
    #}

}

# modules/dart/manifests/subsys/picaps/apache.pp
#
# Synopsis:
#       Appache HTTP server support for PICAPS servers


class dart::subsys::picaps::apache {

    File {
        owner   => 'root',
        group   => 'root',
        mode    => 0644,
        require => Package['httpd'],
        before  => Service['httpd'],
    }

    class { '::apache':
    }

    user { 'apache':
        provider => 'useradd',
        uid    => 48,
        gid    => 48,
        home   => '/var/www',
        system => true,
        before => Class['::apache'],
    }

    group { 'apache':
        provider    => 'groupadd',
        gid         => 48,
        system      => true,
        before      => User['apache'],
    }

    file { '/var/www/html/index.html':
        content => template('dart/picaps/index.html'),
    }

    file { '/var/www/cgi-bin/checkWeb.cgi':
        mode    => 0755,
        content => template('dart/picaps/checkWeb.cgi'),
    }

    #apache::site_config { 'ssl':
    #    source  => 'puppet:///modules/dart/picaps_servers/picaps-httpd-ssl.conf',
    #}

    # Serve up /local -- locally mirrored parts of /pub as used by AOS nodes.
    apache::site_config { 'local':
        source  => 'puppet:///modules/dart/httpd/local.conf',
    }

    # Serve up /pub -- all of /pub but access requires WAN traversal.
    apache::site_config { 'pub':
        source  => 'puppet:///modules/dart/httpd/pub.conf',
    }

}

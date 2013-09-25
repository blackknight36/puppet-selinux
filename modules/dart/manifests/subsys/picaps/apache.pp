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

    package { 'httpd':
        ensure  => installed,
    }

    user { 'apache':
        provider => 'useradd',
        uid    => 48,
        gid    => 48,
        home   => '/var/www',
        system => true,
        before => Package['httpd'],
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

    #apache::site-config { 'ssl':
    #    source  => 'puppet:///modules/dart/picaps-servers/picaps-httpd-ssl.conf',
    #}

    service { 'httpd':
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => [
            Package['httpd'],
        ],
    }

}

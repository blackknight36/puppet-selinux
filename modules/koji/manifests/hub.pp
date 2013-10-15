# modules/koji/manifests/hub.pp
#
# Synopsis:
#       Configures a host to provide the Koji-Hub.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       db_host                 host name provide Koji database
#
#       db_user                 user name for database connection
#
#       db_passwd               password needed for database connection
#
#       web_cn                  CN (common name) of web client for SSL


class koji::hub ( $db_host, $db_user, $db_passwd, $web_cn ) {

    include 'koji::params'

    package { $koji::params::hub_packages:
        ensure  => installed,
    }

    class { 'apache':
        network_connect_db  => 'on',
        anon_write          => 'on',
    }

    include 'apache::mod_ssl'

    apache::site-config {
        'ssl':
            source      => 'puppet:///modules/koji/httpd/ssl.conf',
            subscribe   => Class['apache::mod_ssl'];
        'kojihub':
            source      => 'puppet:///modules/koji/hub/kojihub.conf',
            subscribe   => Package[$koji::params::hub_packages];
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Class['apache'],
        notify      => Class['apache'],
        subscribe   => Package[$koji::params::hub_packages],
    }

    $koji_dir = '/srv/koji'

    file { "$koji_dir":
        ensure  => directory,
        mode    => '0755',
        seltype => 'var_t',
    }

    file { [ "$koji_dir/packages", "$koji_dir/repos", "$koji_dir/work",
             "$koji_dir/scratch", ]:
        ensure  => directory,
        owner   => 'apache',
        group   => 'apache',
        mode    => '0755',
        seltype => 'httpd_sys_content_t',
    }

    file { '/etc/koji-hub/hub.conf':
        #group   => 'apache',
        mode    => '0644',
        content => template('koji/hub/hub.conf'),
    }

}

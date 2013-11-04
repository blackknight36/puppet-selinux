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
#
#       top_dir                 directory containing the repos/ directory


class koji::hub ( $db_host, $db_user, $db_passwd, $web_cn, $top_dir ) {

    include 'koji::params'

    package { $koji::params::hub_packages:
        ensure  => installed,
    }

    class { 'apache':
        anon_write          => 'on',
        network_connect_db  => 'on',
        use_nfs             => 'on',
    }

    include 'apache::mod_ssl'

    apache::module_config {
        '99-prefork':
            source      => 'puppet:///modules/koji/httpd/99-prefork.conf';
        '99-worker':
            source      => 'puppet:///modules/koji/httpd/99-worker.conf';
    }

    apache::site-config {
        'ssl':
            source      => 'puppet:///modules/koji/httpd/ssl.conf',
            subscribe   => Class['apache::mod_ssl'];
        'kojihub':
            content     => template('koji/hub/kojihub.conf'),
            subscribe   => Package[$koji::params::hub_packages];
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Class['apache'],
        notify      => Class['apache'],
        subscribe   => Package[$koji::params::hub_packages],
    }

    file { "${top_dir}":
        ensure  => directory,
        mode    => '0755',
        seltype => 'var_t',
    }

    file { [ "${top_dir}/packages", "${top_dir}/repos", "${top_dir}/work",
             "${top_dir}/scratch", ]:
        ensure  => directory,
        owner   => 'apache',
        group   => 'apache',
        mode    => '0755',
        seltype => 'httpd_sys_content_t',
    }

    file { '/etc/koji-hub/hub.conf':
        content => template('koji/hub/hub.conf'),
    }

}

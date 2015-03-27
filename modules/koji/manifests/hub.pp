# modules/koji/manifests/hub.pp
#
# == Class: koji::hub
#
# Manages the Koji Hub component on a host.
#
# This manages the Koji Hub, an XML-RPC server running under mod_wsgi in
# Apache's httpd.  It also manages Koji's skeleton file system.
#
# === Parameters
#
# ==== Required
#
# [*db_host*]
#   Name of host that provides the Koji database.
#
# [*db_user*]
#   User name for the Koji database connection.
#
# [*db_passwd*]
#   Password for the Koji database connection.
#
# [*web_cn*]
#   Common Name (CN) of the web client for SSL authentication.
#
# [*top_dir*]
#   Directory containing the "repos/" directory.
#
# ==== Optional
#
# [*debug*]
#   Enable verbose debugging for the Koji Hub.
#   One of: true or false (default).
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::hub (
        $db_host,
        $db_user,
        $db_passwd,
        $web_cn,
        $top_dir,
        $debug=false,
    ) inherits ::koji::params {

    validate_bool($debug)

    include '::apache::params'

    package { $koji::params::hub_packages:
        ensure  => installed,
    }

    class { 'apache':
        anon_write         => true,
        network_connect_db => true,
        use_nfs            => true,
    }

    include 'apache::mod_ssl'

    apache::module_config {
        '99-prefork':
            source => 'puppet:///modules/koji/httpd/99-prefork.conf';
        '99-worker':
            source => 'puppet:///modules/koji/httpd/99-worker.conf';
    }

    apache::site_config {
        'ssl':
            source    => 'puppet:///modules/koji/httpd/ssl.conf',
            subscribe => Class['apache::mod_ssl'];
        'kojihub':
            content   => template('koji/hub/kojihub.conf'),
            subscribe => Package[$koji::params::hub_packages];
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$apache::params::services],
        notify    => Service[$apache::params::services],
        subscribe => Package[$koji::params::hub_packages],
    }

    file { $top_dir:
        ensure  => directory,
        mode    => '0755',
        seltype => 'var_t',
    }

    file { [
                "${top_dir}/packages",
                "${top_dir}/repos",
                "${top_dir}/scratch",
                "${top_dir}/work",
            ]:
        ensure  => directory,
        owner   => 'apache',
        group   => 'apache',
        mode    => '0755',
        seltype => 'public_content_rw_t',
    }

    file { '/etc/koji-hub/hub.conf':
        content => template('koji/hub/hub.conf'),
    }

}

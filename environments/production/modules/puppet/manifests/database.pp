# modules/puppet/manifests/database.pp
#
# == Class: puppet::database
#
# Configures a host as a puppet database.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   Michael Watters <michael.watters@dart.biz>


class puppet::database {

    $puppetdb_database = hiera('puppetdb_database')
    $puppetdb_user = hiera('puppetdb_user')
    $puppetdb_passwd = hiera('puppetdb_passwd')

    openssl::ca_certificate { 'puppet-ca':
      source => '/etc/puppetlabs/puppet/ssl/certs/ca.pem',
    }

    yumrepo {['base', 'updates']:
        exclude => 'postgresql*',
    }

    package {'pgdg-centos94':
        ensure   => installed,
        provider => 'rpm',
        source   => 'https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm',
    }

    include 'puppet::params'

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$puppet::params::db_services],
        notify      => Service[$puppet::params::db_services],
        subscribe   => Package[$puppet::params::db_packages],
    }

    package { $puppet::params::db_packages:
        ensure => installed,
        notify => Service[$puppet::params::db_services],
    }

    iptables::tcp_port {
        'puppet_database':  port => '8081';
    }

    iptables::tcp_port {
        'postgresql':  port => '5432';
    }

    $ssldir = $::operatingsystem ? {
        'Fedora' => '/var/lib/puppet/ssl',
        'CentOS' => '/etc/puppetlabs/puppet/ssl',
    }

    file { '/etc/puppetlabs/puppetdb/ssl/private.pem':
        ensure => file,
        owner  => 'puppetdb',
        group  => 'puppetdb',
        mode   => '0600',
        source => "${ssldir}/private_keys/${::fqdn}.pem",
    }

    file { '/etc/puppetlabs/puppetdb/ssl/public.pem':
        ensure => file,
        owner  => 'puppetdb',
        group  => 'puppetdb',
        mode   => '0600',
        source => "${ssldir}/certs/${::fqdn}.pem",
    }
    
    file { '/etc/puppetlabs/puppetdb/ssl/ca.pem':
        ensure => file,
        owner  => 'puppetdb',
        group  => 'puppetdb',
        mode   => '0600',
        source => "${ssldir}/certs/ca.pem",
    }

    file { '/etc/puppetlabs/puppetdb/conf.d/database.ini':
        ensure => file,
        mode => '0644',
        content => template('puppet/puppetdb/database.ini.erb'),
    }

    service { $puppet::params::db_services:
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
    }

    class { 'postgresql::globals':
        encoding => 'UTF-8',
        datadir => '/var/lib/pgsql/9.4/data',
        version => '9.4',
    } ->

    class { 'postgresql::server':
        pg_hba_conf_defaults => false,
        listen_addresses     => '*',
    }

    postgresql::server::role{'postgres':
        password_hash => postgresql_password('postgres', 'postgres'),
        createdb      => true,
        createrole    => true,
        replication   => true,
        superuser     => true,
    }

    postgresql::server::role{$puppetdb_user:
        password_hash    => postgresql_password($puppetdb_user, $puppetdb_passwd),
    } ->

    postgresql::server::db{$puppetdb_database:
        user     => $puppetdb_user,
        password => postgresql_password($puppetdb_user, $puppetdb_passwd),
        owner    => $puppetdb_user,
        encoding => 'UTF-8',
    }

    postgresql::server::pg_hba_rule{'allow application network access':
        description => '"local" is for Unix domain socket connections only',
        type        => 'local',
        database    => 'all',
        user        => 'all',
        auth_method => 'trust',
    }

    postgresql::server::pg_hba_rule{'IPv4 connections':
        description => 'IPv4 connections',
        type        => 'host',
        database    => 'all',
        user        => 'all',
        address     => '0.0.0.0/0',
        auth_method => 'md5',
    }

    postgresql::server::pg_hba_rule{'IPv4 local connections':
        description => 'IPv4 local connections',
        type        => 'host',
        database    => 'all',
        user        => 'all',
        address     => '127.0.0.1/32',
        auth_method => 'trust',
    }

    postgresql::server::pg_hba_rule{'IPv6 local connections':
        description => 'IPv6 local connections',
        type        => 'host',
        database    => 'all',
        user        => 'all',
        address     => '::1/128',
        auth_method => 'md5',
    }

}

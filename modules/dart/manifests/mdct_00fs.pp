# modules/dart/manifests/mdct_00fs.pp
#
# == Class: dart::mdct_00fs
#
# Manages the MDCT/PMES file server.
#
# === Parameters
#
# ==== Required
#
# [* rsync_proxy *]
#   The proxy that mirrmaid is to use, for those configurations which require
#   one.
#
# ==== Optional
#
# === Notes
#   This host was already deployed with critical configuration changes, most
#   of which were applied without the use of any CMS such as Puppet.  To
#   prevent adverse effects this class does not yet inherit from
#   dart::abstract::*_server_node as it ideally would.  It does now at least
#   inherit from dart::abstract::base_node through very careful review of
#   incremental reconciliation and many "puppet agent --test --noop" runs.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


#@# class dart::mdct_00fs inherits dart::abstract::unguarded_server_node {
class dart::mdct_00fs (
        $rsync_proxy,
    ) inherits ::dart::abstract::base_node {

    #@# From server_node.pp {{{
    include '::dart::abstract::packages::net_tools'
    #@# From server_node.pp }}}

    ####
    # Other resources specific to mdct-00fs:
    ####

    class { '::apache':
        server_admin => 'Bryan_Coleman@dart.biz',
    }

    ::apache::site_config {
        'git':
            source  => 'puppet:///modules/dart/httpd/git.conf';
        'pub':
            source  => 'puppet:///modules/dart/httpd/pub.conf';
    }

    # This symlink exists for backwards compatibility.  Anything wanting
    # access to http://mdct-00fs/ftp/pub should instead simply use
    # http://mdct-00fs/pub which is the de facto standard on all other hosts.
    # (See the site_config for pub above).
    file  { '/var/www/html/ftp':
        ensure => link,
        target => '/var/ftp',
    }

    include '::flock_herder'
    include '::git_daemon'

    class { '::mirrmaid':
        ensure  => latest,
    }

    # Configure SSH keys to permit mirrmaid to make passwordless connections
    # to the Picaps servers as needed for both mirrmaid-picaps and
    # mirrmaid-yum-fanout configurations.
    #
    # TODO: move this to openssh module as a definition there.
    file { '/etc/mirrmaid/.ssh':
        ensure  => directory,
        owner   => 'mirrmaid',
        group   => 'mirrmaid',
        mode    => '0600',      # puppet will +x for directories
        force   => true,
        purge   => true,
        recurse => true,
        require => Class['::mirrmaid'],
        source  => 'puppet:///modules/dart/mirrmaid/.ssh',
    }

    # This config is merely note referring the reader to the others.
    ::mirrmaid::config { 'mirrmaid':
        source      => 'puppet:///modules/dart/mirrmaid/mirrmaid.conf',
        cron_source => 'puppet:///modules/dart/mirrmaid/mirrmaid.cron',
    }

    ::mirrmaid::config { 'mirrmaid-picaps':
        source      => 'puppet:///modules/dart/mirrmaid/mirrmaid-picaps.conf',
        cron_source => 'puppet:///modules/dart/mirrmaid/mirrmaid-picaps.cron',
    }

    ::mirrmaid::config { 'mirrmaid-fedora':
        source       => 'puppet:///modules/dart/mirrmaid/mirrmaid-fedora.conf',
        cron_content => template('dart/mirrmaid/mirrmaid-fedora.cron'),
    }

    ::mirrmaid::config { 'mirrmaid-mariadb':
        source       => 'puppet:///modules/dart/mirrmaid/mirrmaid-mariadb.conf',
        cron_content => template('dart/mirrmaid/mirrmaid-mariadb.cron'),
    }

    ::mirrmaid::config { 'mirrmaid-rpmfusion':
        source       => 'puppet:///modules/dart/mirrmaid/mirrmaid-rpmfusion.conf',
        cron_content => template('dart/mirrmaid/mirrmaid-rpmfusion.cron'),
    }

    ::mirrmaid::config { 'mirrmaid-yum-fanout':
        source      => 'puppet:///modules/dart/mirrmaid/mirrmaid-yum-fanout.conf',
        cron_source => 'puppet:///modules/dart/mirrmaid/mirrmaid-yum-fanout.cron',
    }

    include '::picaps::backup_agent'

    class { '::vsftpd':
        source        => 'puppet:///modules/dart/vsftpd/vsftpd.conf',
        allow_use_nfs => false,
    }

}

# vim: foldmethod=marker

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
# ==== Optional
#
# === Notes
#   This host was already deployed with critical configuration changes, most
#   of which were applied without the use of any CMS such as Puppet.  To
#   prevent adverse effects much of this class is effectively disabled, except
#   any changes to be applied since inception of this class.  Future builds of
#   this host would ideally leverage much more use of a CMS.
#
#   In the meantime, the comment tag "#@#" indicates where this class could
#   have applied certain resources (likely through inheritance), but were
#   defeated for reasons stated above.  They're kept here as a reminder or so
#   that they may be selectively enabled with extreme care.  In such a case,
#   it would be very wise to diff against the base classes (or other correct
#   origin) to ensure current practices are followed as things here are quite
#   likely stale to some extent.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


#@# class dart::mdct_00fs inherits dart::abstract::unguarded_server_node {
class dart::mdct_00fs {

    #@# From base_node {{{

    #@# include '::cachefilesd'
    include '::chrony'
    include '::cron::daemon'
    include '::dart::abstract::packages::base'
    include '::dart::subsys::dns::no_dns_hosts'
    #@# include '::dart::subsys::filesystem'
    include '::logwatch'
    #@# include '::openssh::server'
    include '::prophile'

    class { '::puppet::client':
    }

    include '::sudo'
    include '::timezone'
    #@# From base_node }}}

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
        source  => 'puppet:///private-host/mirrmaid/.ssh',
    }

    # This config is merely note referring the reader to the others.
    ::mirrmaid::config { 'mirrmaid':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid.cron',
    }

    ::mirrmaid::config { 'mirrmaid-picaps':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-picaps.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-picaps.cron',
    }

    ::mirrmaid::config { 'mirrmaid-fedora':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-fedora.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-fedora.cron',
    }

    ::mirrmaid::config { 'mirrmaid-mariadb':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-mariadb.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-mariadb.cron',
    }

    ::mirrmaid::config { 'mirrmaid-rpmfusion':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-rpmfusion.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-rpmfusion.cron',
    }

    ::mirrmaid::config { 'mirrmaid-yum-fanout':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-yum-fanout.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-yum-fanout.cron',
    }

    include '::picaps::backup_agent'

    class { '::vsftpd':
        source        => 'puppet:///private-host/vsftpd/vsftpd.conf',
        allow_use_nfs => false,
    }

}

# vim: foldmethod=marker

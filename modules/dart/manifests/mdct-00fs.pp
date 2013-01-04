# modules/dart/manifests/mdct-00fs.pp

#@# Not ready to take on full-on management; scope is very limited at this time.
#@# class dart::mdct-00fs inherits dart::abstract::server_node {
class dart::mdct-00fs {

    #@# From base_node
    #@# include authconfig
    #@# include autofs
    include cron::daemon
    #@# include cachefilesd
    include dart::no-dns-hosts
    include logwatch
    include ntp
    #@# include openssh-server
    include packages::base
    include puppet::client
    #@# include rpcidmapd
    include sudo
    include timezone
    #@# include xorg-server

    #@# From server_node.pp
    include packages::net_tools


    ####
    # Other resources specific to mdct-00fs:
    ####

    include 'flock-herder'
    include 'git-daemon'

    include 'mirrmaid'

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
        require => Class['mirrmaid'],
        source  => 'puppet:///private-host/mirrmaid/.ssh',
    }

    # This config is merely note referring the reader to the others.
    mirrmaid::config { 'mirrmaid':
        source => 'puppet:///private-host/mirrmaid/mirrmaid.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid.cron',
    }

    mirrmaid::config { 'mirrmaid-picaps':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-picaps.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-picaps.cron',
    }

    mirrmaid::config { 'mirrmaid-fedora':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-fedora.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-fedora.cron',
    }

    mirrmaid::config { 'mirrmaid-mariadb':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-mariadb.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-mariadb.cron',
    }

    mirrmaid::config { 'mirrmaid-rpmfusion':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-rpmfusion.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-rpmfusion.cron',
    }

    mirrmaid::config { 'mirrmaid-yum-fanout':
        source  => 'puppet:///private-host/mirrmaid/mirrmaid-yum-fanout.conf',
        cronjob => 'puppet:///private-host/mirrmaid/mirrmaid-yum-fanout.cron',
    }

    include 'picaps-backup-agent'
    include 'repoview'


    package { "createrepo":
        ensure      => installed,
    }

}

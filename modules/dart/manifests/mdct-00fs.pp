# modules/dart/manifests/mdct-00fs.pp

#@# Not ready to take on full-on management; scope is very limited at this time.
#@# class dart::mdct-00fs inherits dart::abstract::server_node {
class dart::mdct-00fs {

    #@# From base_node
    #@# include authconfig
    #@# include autofs
    include cron::daemon
    #@# # include cups
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

    mirrmaid::config { 'mirrmaid':
        source => 'puppet:///private-host/mirrmaid/mirrmaid.conf',
    }

    mirrmaid::config { 'mirrmaid-testing':
        source => 'puppet:///private-host/mirrmaid/mirrmaid-testing.conf',
    }

    include 'picaps-backup-agent'
    include 'repoview'


    package { "createrepo":
        ensure      => installed,
    }

}

# /etc/puppet/modules/dart/manifests/classes/mdct-00fs.pp

#@# Not ready to take on full-on management; scope is very limited at this time.
#@# class dart::mdct-00fs inherits dart::server_node {
class dart::mdct-00fs {

    #@# From base_node
    #@# include authconfig
    #@# include autofs
    #@# # include cups
    #@# include cachefilesd
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
    include 'mdct-puppeteer-admin'
    include 'mirrmaid'
    include 'repoview'


    package { "createrepo":
        ensure      => installed,
    }

    package { "picaps-backup-agent":
        ensure      => installed,
    }

}

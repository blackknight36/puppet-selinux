# modules/dart/manifests/mdct_00ut.pp
#
# Synopsis:
#       General purpose utility server for Corporate/Engineering
#
# Contact:
#       John Florian

class dart::mdct_00ut inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'

    file { '/etc/davfs2/secrets':
        group   => 'root',
        mode    => '0600',
        owner   => 'root',
        source  => 'puppet:///private-host/secrets',
        require => [
            Package['davfs2'],
        ],
    }

    package { 'davfs2':
        ensure  => 'installed',
    }

    autofs::map_entry { '/mnt/eid':
        mount   => '/mnt',
        key     => 'eid',
        options => '-fstype=davfs,rw',
        remote  => 'http://teams.dart.biz/sites/ENG/EVC/EIDLibrary/CurrentEID',
        require => [
            File['/etc/davfs2/secrets'],
        ],
    }

    file { '/etc/cron.d/spsync':
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        source  => 'puppet:///modules/dart/utility_servers/mdct-00fs-cron',
        require => [
            File['/storage/slideshow'],
            File['/storage/slideshow/priority'],
        ],
    }

    file {'/storage/slideshow':
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
    }

    file {'/storage/slideshow/priority':
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
    }

    #mount {'/storage/slideshow':
    #    device  => '/mnt/eid',
    #    fstype  => 'auto',
    #    options => 'bind',
    #    ensure  => 'mounted',
    #    require => [
    #        File['/storage/slideshow'],
    #    ],
    #}

    # AOS devices pull media-playback content using rsync.
    class { 'rsync::server':
        export_all_ro   => true,
        source          => 'puppet:///modules/dart/utility_servers/rsyncd/rsyncd.conf',
        xinetd_source   => 'puppet:///modules/dart/utility_servers/rsyncd/rsync.xinetd',
    }

    # That same media-playback content is pushed in via Windows systems.
    #include 'samba'

    # Additional content comes in the form of MDC's weather imagery.  The
    # media_disbursal module knows how to retrieve that imagery and merge it
    # with the content from the Windows system and disburse all such content
    # in a location where media-playback clients can utilize it.
    #include 'media_disbursal'

    # Other packages required by a plant utility server
    #if $::operatingsystem == 'Fedora' and $::operatingsystemrelease > 15 {
    #    package { [
    #        'open-vm-tools',
    #        ]:
    #        ensure => 'installed',
    #    }
    #}

}

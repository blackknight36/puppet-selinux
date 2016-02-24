# modules/media_disbursal/manifests/init.pp
#
# Synopsis:
#       Configures a host to have access to MDC's weather imagery media.
#
# Parameters:
#       NONE
#
# Requires:
#       Class['rsync::server']
#       Class['samba']

class media_disbursal {

    # Establish a root for shared slide-show file resources.
    file { '/storage/slideshow':
        before  => [
            Class['samba'],
            Class['rsync::server'],
        ],
        ensure  => directory,
        group   => 'root',
        mode    => '3777',
        owner   => 'root',
        require => Class['::dart::subsys::filesystem'],
    } ->

    # Establish a mount point for shared weather-media slide-show file
    # resources.
    file { '/storage/slideshow/weathermedia':
        before  => [
            Class['samba'],
            Class['rsync::server'],
        ],
        ensure  => directory,
    } ->

    # mdct-00fs has the master copies of weather-media that
    # plant_utility_server_node will need via NFS for disbursal to the AOS
    # devices.
    mount { '/storage/slideshow/weathermedia':
        atboot  => true,
        device  => 'mdct-00fs.dartcontainer.com:/storage/pub/slideshow/weathermedia',
        ensure  => 'mounted',
        fstype  => 'nfs',
        options => 'tcp,hard,intr,ro',
    } ->

    # This script does all the work.
    file { '/usr/local/bin/disburse-media':
        group   => 'root',
        mode    => '0754',
        owner   => 'root',
        require => Class['samba'],
        source  => 'puppet:///modules/media_disbursal/disburse-media',
    }

    exec { '/usr/local/bin/disburse-media':
        creates => '/var/lock/disburse-media',
        require => File['/usr/local/bin/disburse-media'],
    }


}

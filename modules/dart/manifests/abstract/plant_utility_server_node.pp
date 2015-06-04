# modules/dart/manifests/abstract/plant_utility_server_node.pp
#
# Synopsis:
#       This class is used primarily for servers that provided shared access
#       to media content used by the AOS media-playback devices.

class dart::abstract::plant_utility_server_node inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'

    # AOS devices pull media-playback content using rsync.
    class { 'rsync::server':
        export_all_ro   => true,
        source          => 'puppet:///modules/dart/utility_servers/rsyncd/rsyncd.conf',
        xinetd_source   => 'puppet:///modules/dart/utility_servers/rsyncd/rsync.xinetd',
    }

    # That same media-playback content is pushed in via Windows systems.
    include 'samba'

    # Additional content comes in the form of MDC's weather imagery.  The
    # media_disbursal module knows how to retrieve that imagery and merge it
    # with the content from the Windows system and disburse all such content
    # in a location where media-playback clients can utilize it.
    include 'media_disbursal'

    # Other packages required by a plant utility server
    if $::operatingsystem == 'Fedora' and $::operatingsystemrelease > 15 {
        package { [
            'open-vm-tools',
            ]:
            ensure => 'installed',
        }
    }

}

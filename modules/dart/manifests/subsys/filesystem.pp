# modules/dart/manifests/subsys/filesystem.pp
#
# == Class: dart::subsys::filesystem
#
# Manage basic filesystem primitives.
#
# === Parameters
#
# None
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::filesystem {

    File {
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seluser => 'system_u',
        selrole => 'object_r',
    }

    # $exports is the standard location exported file systems that are to be
    # shared via NFS.  Typically those file systems would be bind-mounted here
    # from their canonical mount point in $storage.
    $exports = '/exports'

    # $opt is our standard location for packaged software not available via
    # rpm.  This directory is expected to maintain the following hierarchy:
    #   $opt/
    #       vendor1
    #           product1_from_vendor1
    #           product2_from_vendor1
    #       vendor2
    #           product1_from_vendor2
    #           product2_from_vendor2
    $opt = '/opt'

    # $storage is the standard location for statically mounted of file
    # systems.  These may be backed by a physical or virtual device.
    $storage = '/storage'

    file {
        $opt:
            seltype => 'usr_t',
            ;
        $exports:
            seltype => 'nfs_t',
            ;
        $storage:
            ;
    }

}

# modules/dart/manifests/subsys/filesystem/exported_storage.pp
#
# == Define: dart::subsys::filesystem::exported_storage
#
# Manages mounting and exporting of an external file system.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   A unique identifier for the exported storage instance.  This determines,
#   in part, the path of the mount point and the export directory.
#
# [*backing*]
#   The block device providing the backing storage.  This is what is being
#   mounted and exported.
#
# ==== Optional
#
# [*ensure*]
#   Control what to do with this mount.  Defaults to 'mounted'.
#
#   Set to 'mounted'  to add it to the fstab and mount it.  Set this attribute
#   to 'unmounted' to make sure the filesystem is in the fstab but not mounted
#   (if the filesystem is currently mounted, it will be unmounted).  Set it to
#   'absent' to unmount (if necessary) and remove the filesystem from the
#   fstab.  Set to 'present' to add to fstab but not change mount/unmount
#   status.
#
# [*fstype*]
#   The mount type.  Defaults to 'auto'.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2015-2016 John Florian


define dart::subsys::filesystem::exported_storage (
        $backing,
        $ensure='mounted',
        $fstype='auto',
    ) {

    $filesystem = hiera('filesystem')
    $fs_opts = $filesystem['mount_opts']['fs']
    $store = "${::dart::subsys::filesystem::storage}/${name}"
    $export = "${::dart::subsys::filesystem::exports}/${name}"

    ::filesystem::mount { $store:
        ensure  => $ensure,
        backing => $backing,
        fstype  => $fstype,
        options => $fs_opts,
        before  => Class['::nfs::server'],
    } ->

    ::filesystem::mount { $export:
        ensure  => $ensure,
        backing => $store,
        fstype  => $fstype,
        options => 'bind',
        before  => Class['::nfs::server'],
    }

}


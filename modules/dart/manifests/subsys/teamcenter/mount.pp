# modules/dart/manifests/subsys/teamcenter/mount.pp
#
# == Define: dart::subsys::teamcenter::mount
#
# Manages a CIFS mount whose source is a TeamCenter data volume.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the mount instance.
#
# [*ensure*]
#   TODO: implement this parameter
#   Instance is to be 'present' (default) or 'absent'.
#
# [*host*]
#   Name of host that provides the TeamCenter data volume.
#
# [*share_name*]
#   CIFS share name of the TeamCenter data volume share.
#
# [*owner*]
#   User identity that is to own the mount point.
#
# [*group*]
#   Group identity to which the mount point has membership.
#
# [*mode*]
#   File system access mode for the mount point.
#
# [*options*]
#   Additional mount options.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define dart::subsys::teamcenter::mount (
        $host,
        $share_name,
        $owner='root',
        $group='root',
        $mode='0775',
        $options='ro'
    ) {

    file { "/srv/${host}-${share_name}":
        ensure => directory,
        owner  => $owner,
        group  => $group,
        mode   => $mode,
    }

    mount { "/srv/${host}-${share_name}":
        ensure  => 'mounted',
        atboot  => true,
        device  => "//${host}/${share_name}",
        fstype  => 'cifs',
        options => "${options},dir_mode=${mode}",
        require => [
            File["/srv/${host}-${share_name}"],
        ],
    }

}

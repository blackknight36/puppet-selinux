# modules/autofs/manifests/mount_point.pp
#
# == Define: autofs::mount_point
#
# Configure a mount point for the autofs auto-mounter.  Each
# autofs::mount_point instance requires one or more autofs::map_entry
# instances as well since, at this time, only indirect mounts are supported by
# this puppet module.
#
# While this is the preferred way to manage autofs, it does require inclusion
# of the autofs class with the legacy parameter set to false.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the mount point unless the "mount" parameter
#   is not set in which case this must provide the value normally set with
#   the "mount" parameter.
#
# [*mount*]
#   The directory name that is to serve as the mount point.  This directory
#   need not exist as the autofs service will create it, if necessary.  If the
#   directory does exist, any files contained there prior to activating the
#   mount will be inaccessible upon activation.  They will not be permanently
#   lost, just inaccessible for the duration of the mount.
#
# [*options*]
#   An optional space-separated list.  Items without leading dashes (-) are
#   taken as options (-o) to mount(8). Arguments with leading dashes are
#   considered options for the maps associated with this mount point.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define autofs::mount_point ($mount=undef, $options=undef) {

    include 'autofs::params'

    $real_mount = $mount ? {
        undef   => $name,
        default => $mount,
    }

    $sterile_name = regsubst($real_mount, '[^\w]+', '_', 'G')

    $map = "/etc/auto.master.d/${sterile_name}.map"

    concat::fragment { "master_entry_for_${sterile_name}":
      target    => 'autofs_master_map',
      content   => template('autofs/master_entry.erb'),
    }

    concat { "map_for_${sterile_name}":
        path    => "${map}",
        notify  => Service[$autofs::params::service_name],
    }

}

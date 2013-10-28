# modules/autofs/manifests/map_entry.pp
#
# == Define: autofs::map_entry
#
# Configure a mount point's map entry for the autofs auto-mounter.  Each
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
#   An arbitrary identifier for the mount point's map entry.
#
# [*mount*]
#   The directory name that is to serve as the mount point.  This parameter
#   must match exactly that provided to your associated autofs::mount_point.
#
# [*options*]
#   An optional space-separated list of options (-o) to mount(8).
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define autofs::map_entry ($mount, $key, $options=undef, $remote) {

    include 'autofs::params'

    $sterile_name = regsubst($mount, '[^\w]+', '_', 'G')

    concat::fragment { "map_entry_for_${sterile_name}":
      target    => "map_for_${sterile_name}",
      content   => template('autofs/map_entry.erb'),
    }

}

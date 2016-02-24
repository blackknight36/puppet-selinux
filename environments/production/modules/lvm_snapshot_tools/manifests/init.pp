# modules/lvm_snapshot_tools/manifests/init.pp
#
# == Class: lvm_snapshot_tools
#
# Manages lvm-snapshot-tools on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*min_snapshot_size*]
#   Each VG must have sufficient free PEs for the creation of the snapshots.
#   All free PEs for the VG will be equally apportioned for each of the
#   snapshot LVs.  If the calculated snapshot size would have fewer than
#   "min_snapshot_size" PEs, the backup-snapshot process will abort with an
#   error.  The default is 10 PEs.
#
# [*origin_vgs*]
#   An array of the VG names where the snapshots are to be taken.  The
#   backup-snapshot tool will attempt to snapshot all active, non-swap LVs
#   associated with these VGs.  The default is an empty array.
#
# [*snapshot_prefix*]
#   The name prefix to be given to each of the snapshot LVs.  The actual LV
#   name will be this suffix with "-#" (e.g., "backup_snapshot_0",
#   "backup_snapshot_1", and so on).  The name should be unique and not
#   conflict with other LV names (within their respective VGs) that may exist
#   on the system.  The default is "backup_snapshot".
#
# [*snapshots_root*]
#   The directory where all snapshot LVs will be mounted.  It is the one and
#   only directory that should be backed up (recursively, of course).  The
#   default value "/var/spool/backup_snapshots" has been chosen to be unlikely
#   to conflict with autofs which may "own" the more conventional /mnt
#   directory.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class lvm_snapshot_tools (
        $min_snapshot_size=10,
        $origin_vgs=[],
        $snapshot_prefix='backup_snapshot',
        $snapshots_root='/var/spool/backup_snapshots',
    ) inherits ::lvm_snapshot_tools::params {

    package { $::lvm_snapshot_tools::params::packages:
        ensure => installed,
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::lvm_snapshot_tools::params::packages],
    }

    file { '/etc/backup-snapshot.conf':
        content => template('lvm_snapshot_tools/backup-snapshot.conf.erb'),
    }

}

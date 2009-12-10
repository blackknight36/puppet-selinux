# /etc/puppet/modules/local-mounts/manifests/init.pp

class local-mounts {

    define mount_point ($owner, $group, $mode) {
        file { "$name":
            ensure      => directory,
            group       => "$group",
            mode        => "$mode",
            owner       => "$owner",
        }
    }

    define logical_volume ($vg_name, $size) {
        exec { "lvcreate --size $size --name ${name} $vg_name":
            unless      => "test -b /dev/mapper/${vg_name}-${name}",
        }
    }

    define file_system ($type) {
        exec { "mkfs -t $type $name":
            # kludge to detect presence of an existing file system
            unless      => "tune2fs -u root ${name}",
        }
    }

    # By convention, this is a mount point for all local mounts; /mnt is
    # reserved for autofs.
    $local_mounts="/mnt-local"
    mount_point { "$local_mounts":
        group   => "root",
        mode    => 755,
        owner   => "root",
    }

    define local_file_system ($size, $type, $vg_name) {
        logical_volume { "lv_${name}":
            size        => "$size",
            vg_name     => "$vg_name",
        }
        file_system { "/dev/mapper/${vg_name}-lv_${name}":
            require     => Logical_volume["lv_${name}"],
            type        => "$type",
        }
        mount_point { "$local_mounts/$name":
            group       => "root",
            mode        => "755",
            owner       => "root",
            require     => Mount_point["$local_mounts"],
        }
        mount { "$local_mounts/${name}":
            atboot      => true,
            device      => "/dev/mapper/${vg_name}-lv_${name}",
            ensure      => mounted,
            fstype      => "$type",
            options     => "defaults",
            require     => [
                File_system["/dev/mapper/${vg_name}-lv_${name}"],
                Mount_point["$local_mounts/$name"],
            ]
        }
    }

    case $hostname {
        mdct-dev12: {
            local_file_system { "development":
                size    => "5g",
                type    => "ext4",
                vg_name => "vg_${hostname}",
            }
        }
    }

}

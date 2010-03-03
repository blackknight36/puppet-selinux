# /etc/puppet/modules/storage-relocation/manifests/init.pp

class storage-relocation {

    include autofs
    include mysql-server

    define replace_original_with_symlink_to_alternate($original, $backup, $alternate) {
        # Make a local backup of the original file or directory that can be
        # used to manually diff with an alternate copy that is presumably
        # carried over from prior OS releases.  The "file" type does provide a
        # backup parameter, but I've seen it fail with directory structures
        # containing intra-relative symlinks; hence this workaround.
        exec { "archive-$original-to-$backup":
            command     => "cp -a $original $backup",
            unless      => "test -e $backup",
        }

        # Now make a symlink from the original location to an alternate one.
        file { "$original":
            ensure	=> $alternate,
            force       => true,
            require     => [
                Exec["archive-$original-to-$backup"],
                Service["autofs"],
            ],
        }

    }

    case $hostname {
        mdct-dev12: {
            $SUFFIX=".orig-${operatingsystem}${operatingsystemrelease}"

            file { "/j":
                ensure	=> "/mnt-local/storage/j/",
                require => Service["autofs"],
            }

            file { "/Pound":
                ensure	=> "/mnt-local/storage/Pound/",
                require => Service["autofs"],
            }

            replace_original_with_symlink_to_alternate { "/etc/libvirt":
                alternate       => "/mnt-local/storage/j/etc/libvirt",
                backup          => "/etc/libvirt$SUFFIX",
                original        => "/etc/libvirt",
            }

            replace_original_with_symlink_to_alternate { "/var/lib/libvirt":
                alternate	=> "/mnt-local/storage/j/var/lib/libvirt",
                backup          => "/var/lib/libvirt$SUFFIX",
                original        => "/var/lib/libvirt",
            }

            replace_original_with_symlink_to_alternate { "/var/lib/mysql":
                alternate	=> "/mnt-local/storage/j/var/lib/mysql",
                backup          => "/var/lib/mysql$SUFFIX",
                original        => "/var/lib/mysql",
                require         => Service["mysqld"],
            }

        }
    }
}

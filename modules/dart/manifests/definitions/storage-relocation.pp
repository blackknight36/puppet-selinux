# /etc/puppet/modules/dart/manifests/definitions/storage-relocation.pp

define replace_original_with_symlink_to_alternate(
        $original, $backup, $alternate,
        $seluser="system_u", $selrole="object_r", $seltype="etc_t"
    ) {

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

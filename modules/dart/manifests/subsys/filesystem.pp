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

    file { '/opt':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'usr_t',
    }

}

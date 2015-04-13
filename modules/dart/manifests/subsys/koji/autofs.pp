# modules/dart/manifests/subsys/koji/autofs.pp
#
# == Class: dart::subsys::koji::autofs
#
# Manages autofs for a Dart host as a Koji RPM package builder.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::koji::autofs inherits ::dart::subsys::koji::params {

    include '::dart::subsys::autofs::common'

    ::autofs::map_entry {

        $::dart::subsys::koji::params::topdir:
            mount   => '/mnt',
            key     => 'koji',
            options => '-rw,hard,nosuid,noatime,fsc',
            remote  => 'mdct-00fs:/storage/projects/koji';

        $::dart::subsys::koji::params::repodir:
            mount   => '/mnt',
            key     => 'dart-repo',
            options => '-rw,hard,nosuid,noatime,fsc',
            remote  => 'mdct-00fs:/storage/projects/dart-repo';

    }

}

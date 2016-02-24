# modules/dart/manifests/subsys/mock/fedora/x86_64.pp
#
# == Class: dart::subsys::mock::fedora::x86_64
#
# Manage mock configuration of Fedora x86_64 for typical Dart use.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::mock::fedora::x86_64 {

    Mock::Target {
        family            => 'fedora',
        target_arch       => 'x86_64',
        base_arch         => 'x86_64',
        legal_host_arches => ['x86_64'],
    }

    ::mock::target {
        'Fedora-18-x86_64': release => '18';
        'Fedora-19-x86_64': release => '19';
        'Fedora-20-x86_64': release => '20';
        'Fedora-21-x86_64': release => '21';
    }

}

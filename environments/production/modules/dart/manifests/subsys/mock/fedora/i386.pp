# modules/dart/manifests/subsys/mock/fedora/i386.pp
#
# == Class: dart::subsys::mock::fedora::i386
#
# Manage mock configuration of Fedora i386 for typical Dart use.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::mock::fedora::i386 {

    Mock::Target {
        family            => 'fedora',
        target_arch       => 'i686',
        base_arch         => 'i386',
        legal_host_arches => ['i386', 'i586', 'i686', 'x86_64'],
    }

    ::mock::target {
        'Fedora-18-i386': release => '18';
        'Fedora-19-i386': release => '19';
        'Fedora-20-i386': release => '20';
        'Fedora-21-i386': release => '21';
        'Fedora-22-i386': release => '22';
    }

}

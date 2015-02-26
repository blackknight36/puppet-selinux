# modules/dart/manifests/subsys/mock.pp
#
# == Class: dart::subsys::mock
#
# Manage mock configuration for typical Dart use.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::mock {

    include '::dart::subsys::mock::fedora::i386'
    include '::dart::subsys::mock::fedora::x86_64'

    ::mock::user {
        'teamcity':;
        'd13677':;
    }


}

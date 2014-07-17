# modules/dart/manifests/abstract/pycharm/community.pp
#
# == Class: dart::abstract::pycharm::community
#
# Configures a host to have JetBrains PyCharm Community Edition.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::pycharm::community {

    #
    # Stable Releases
    #
    # Present policy plan is to enforce absence of old stable releases
    # to ensure that no more than two stable releases are installed at any
    # given time.

    jetbrains::pycharm::release { 'pycharm-community-3.4.1':
        build   => '3.4.1',
        edition => 'community',
    }

#   jetbrains::pycharm::release { 'pycharm-community-3.4':
#       build   => '3.4',
#       edition => 'community',
#       ensure  => 'absent',
#   }

#   #
#   # EAP Releases
#   #

#   jetbrains::pycharm::release { 'pycharm-community-135.889':
#       build   => '135.889',
#       edition => 'community',
#   }

#   jetbrains::pycharm::release { 'pycharm-community-135.763':
#       build   => '135.763',
#       edition => 'community',
#       ensure  => 'absent',
#   }

}

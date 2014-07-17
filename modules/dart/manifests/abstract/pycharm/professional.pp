# modules/dart/manifests/abstract/pycharm/professional.pp
#
# == Class: dart::abstract::pycharm::professional
#
# Configures a host to have JetBrains PyCharm Professional Edition.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::pycharm::professional {

    #
    # Stable Releases
    #
    # Present policy plan is to enforce absence of old stable releases
    # to ensure that no more than two stable releases are installed at any
    # given time.

    jetbrains::pycharm::release { 'pycharm-3.4.1':
        build   => '3.4.1',
        edition => 'professional',
    }

    jetbrains::pycharm::release { 'pycharm-3.4':
        build   => '3.4',
        edition => 'professional',
        ensure  => 'absent',
    }

    #
    # EAP Releases
    #

    jetbrains::pycharm::release { 'pycharm-135.889':
        build   => '135.889',
        edition => 'professional',
    }

    jetbrains::pycharm::release { 'pycharm-135.763':
        build   => '135.763',
        edition => 'professional',
        ensure  => 'absent',
    }

}

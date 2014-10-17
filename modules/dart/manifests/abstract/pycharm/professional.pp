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

    jetbrains::pycharm::release { 'pycharm-professional-3.4.1':
        build   => '3.4.1',
        edition => 'professional',
    }

    jetbrains::pycharm::release { 'pycharm-professional-3.4':
        ensure  => 'absent',
        build   => '3.4',
        edition => 'professional',
    }

    #
    # EAP Releases
    #

    jetbrains::pycharm::release { 'pycharm-professional-139.113':
        build   => '139.113',
        edition => 'professional',
    }

    jetbrains::pycharm::release { 'pycharm-professional-138.2401':
        ensure  => 'absent',
        build   => '138.2401',
        edition => 'professional',
    }

}

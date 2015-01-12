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

    jetbrains::pycharm::release { 'pycharm-professional-4.0.4':
        build   => '4.0.4',
        edition => 'professional',
    }

    jetbrains::pycharm::release { 'pycharm-professional-4.0.3':
        ensure  => 'absent',
        build   => '4.0.3',
        edition => 'professional',
    }

    #
    # EAP Releases
    #

    jetbrains::pycharm::release { 'pycharm-professional-139.431':
        ensure  => 'absent',
        build   => '139.431',
        edition => 'professional',
    }

    jetbrains::pycharm::release { 'pycharm-professional-139.354':
        ensure  => 'absent',
        build   => '139.354',
        edition => 'professional',
    }

}

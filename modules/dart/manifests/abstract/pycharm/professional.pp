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

    jetbrains::pycharm::release {

        'pycharm-professional-4.5.4':
            build   => '4.5.4',
            edition => 'professional',
            ;

        'pycharm-professional-4.5.3':
            ensure  => 'absent',
            build   => '4.5.3',
            edition => 'professional',
            ;

    }

    #
    # EAP Releases
    #

    jetbrains::pycharm::release {

        'pycharm-professional-142.5084':
            build   => '142.5084',
            edition => 'professional',
            ;

        'pycharm-professional-142.4957':
            ensure  => 'absent',
            build   => '142.4957',
            edition => 'professional',
            ;

    }

}

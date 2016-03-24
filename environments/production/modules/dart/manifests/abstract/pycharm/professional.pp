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

    ::jetbrains::pycharm::release {

        'pycharm-professional-2016.1':
            build   => '2016.1',
            edition => 'professional',
            ;

        'pycharm-professional-5.0.4':
            build   => '5.0.4',
            edition => 'professional',
            ;

        'pycharm-professional-5.0.3':
            ensure  => 'absent',
            build   => '5.0.3',
            edition => 'professional',
            ;

    }

    #
    # EAP Releases
    #

    ::jetbrains::pycharm::release {

        'pycharm-professional-143.1183.2':
            ensure  => 'absent',
            build   => '143.1183.2',
            edition => 'professional',
            ;

    }

}

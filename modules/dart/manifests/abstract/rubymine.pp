# modules/dart/manifests/abstract/rubymine.pp
#
# == Class: dart::abstract::rubymine
#
# Maanages JetBrains RubyMine on workstation.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::rubymine {

    #
    # Stable Releases
    #
    # Present policy plan is to enforce absence of old stable releases
    # to ensure that no more than two stable releases are installed at any
    # given time.

    jetbrains::rubymine::release { 'rubymine-8.0.3':
        build   => '8.0.3',
    }

    #
    # EAP Releases
    #

}

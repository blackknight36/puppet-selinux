# modules/dart/manifests/abstract/idea.pp
#
# == Class: dart::abstract::idea
#
# Configures a host to have JetBrains IDEA.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::idea {

    #
    # Stable Releases
    #
    # Present policy plan is to enforce absence of old stable releases
    # to ensure that no more than two stable releases are installed at any
    # given time.

    jetbrains::idea::release { 'ideaIU-14':
        build   => '139.224.1',
    }

    jetbrains::idea::release { 'ideaIU-13.1.4b':
        build   => '135.1230',
    }

    jetbrains::idea::release { 'ideaIU-13.0.1':
        build   => '133.331',
    }

    jetbrains::idea::release { 'ideaIU-12.1.4':
        ensure  => absent,
        build   => '129.713',
    }

    #
    # EAP Releases
    #

    jetbrains::idea::release { 'ideaIU-139.144.2':
        build   => '139.144.2',
    }

    jetbrains::idea::release { 'ideaIU-14-PublicPreview':
        ensure  => absent,
        build   => '138.2458.8',
    }

    jetbrains::idea::release { 'ideaIU-138.1980.1':
        ensure  => absent,
        build   => '138.1980.1',
    }

    jetbrains::idea::release { 'ideaIU-129.961':
        ensure  => absent,
        build   => '129.961',
    }

    jetbrains::idea::release { 'ideaIU-123.150':
        ensure  => absent,
        build   => '123.150',
    }

}

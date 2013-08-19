# modules/dart/manifests/subsys/yum/ovirt.pp

class dart::subsys::yum::ovirt {

    include 'dart::subsys::yum::params'
    include 'tsocks'

    # Rawhide systems begin life as the latest stable release and should be
    # fully puppetized prior to upgrading to rawhide.  Once there, they have
    # no need for this section, which would only throw errors anyway.
    if $operatingsystemrelease != 'Rawhide' {

        yum::repo {'ovirt':
            server_uri  => 'http://ovirt.org/releases',
            pkg_name    => 'ovirt-release-fedora',
            pkg_release => 'noarch',
            use_tsocks  => true,
        }

    }

}

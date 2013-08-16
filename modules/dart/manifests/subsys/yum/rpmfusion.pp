# modules/dart/manifests/subsys/yum/mdct.pp

class dart::subsys::yum::rpmfusion {

    include 'dart::subsys::yum::params'

    # Rawhide systems begin life as the latest stable release and should be
    # fully puppetized prior to upgrading to rawhide.  Once there, they have
    # no need for this section, which would only throw errors anyway.
    if $operatingsystemrelease != 'Rawhide' {

        yum::repo {'rpmfusion-free':
            server_uri  => "$fedora_repo_uri/rpmfusion/free/fedora",
            pkg_name    => 'rpmfusion-free-release',
            pkg_release => "$operatingsystemrelease.noarch",
        }

        yum::repo {'rpmfusion-nonfree':
            server_uri  => "$fedora_repo_uri/rpmfusion/nonfree/fedora",
            pkg_name    => 'rpmfusion-nonfree-release',
            pkg_release => "$operatingsystemrelease.noarch",
        }

    }

}

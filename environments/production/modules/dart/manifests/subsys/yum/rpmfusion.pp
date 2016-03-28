# modules/dart/manifests/subsys/yum/rpmfusion.pp

class dart::subsys::yum::rpmfusion {

    include 'dart::subsys::yum::params'

    # Rawhide systems begin life as the latest stable release and should be
    # fully puppetized prior to upgrading to rawhide.  Once there, they have
    # no need for this section, which would only throw errors anyway.
    if $::operatingsystemrelease != 'Rawhide' and $::operatingsystem == 'Fedora' {

        yum::repo {'rpmfusion-free':
            server_uri  => "${::dart::subsys::yum::params::fedora_repo_uri}/rpmfusion/free/fedora",
            pkg_name    => 'rpmfusion-free-release',
            pkg_release => "${::operatingsystemrelease}.noarch",
        }

        yum::repo {'rpmfusion-nonfree':
            server_uri  => "${::dart::subsys::yum::params::fedora_repo_uri}/rpmfusion/nonfree/fedora",
            pkg_name    => 'rpmfusion-nonfree-release',
            pkg_release => "${::operatingsystemrelease}.noarch",
        }

    }

    # Fedora 23 needs to have the development repos enabled for rpmfusion packages
    if $::operatingsystem == 'Fedora' and $::operatingsystemrelease == '23' {
        yumrepo { 'local-rpmfusion-free-development':
            enabled => 1,
            require => Yum::Repo['rpmfusion-free'],
        }
        yumrepo { 'local-rpmfusion-nonfree-development':
            enabled => 1,
            require => Yum::Repo['rpmfusion-nonfree'],
        }

        yumrepo { ['local-rpmfusion-free', 'local-rpmfusion-free-updates']:
            enabled => 0,
            require => Yum::Repo['rpmfusion-free'],
        }

        yumrepo { ['local-rpmfusion-nonfree', 'local-rpmfusion-nonfree-updates', 'rpmfusion-nonfree-updates-testing']:
            enabled => 0,
            require => Yum::Repo['rpmfusion-nonfree'],
        }
    }
}

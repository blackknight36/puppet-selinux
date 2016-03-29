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
            descr   => 'MDCT mirror of RPM Fusion for Fedora $releasever Free - Development',
            enabled => '1',
            baseurl => 'http://mdct-00fs.dartcontainer.com/ftp/pub/fedora/rpmfusion/free/fedora/development/$releasever/$basearch/os/',
            gpgcheck => '1',
            gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-$releasever',
        }

        yumrepo { 'local-rpmfusion-nonfree-development':
            descr   => 'MDCT mirror of RPM Fusion for Fedora $releasever - Nonfree - Development',
            enabled => '1',
            baseurl => 'http://mdct-00fs.dartcontainer.com/ftp/pub/fedora/rpmfusion/nonfree/fedora/development/$releasever/$basearch/os/',
            gpgcheck => '1',
            gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-$releasever',
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

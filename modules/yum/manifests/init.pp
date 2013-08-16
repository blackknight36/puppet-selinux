# modules/yum/manifests/init.pp

class yum {

    # Stage => first

    file { '/etc/yum.conf':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        source  => [
            'puppet:///private-host/yum/yum.conf',
            'puppet:///private-domain/yum/yum.conf',
            'puppet:///modules/yum/yum.conf',
        ],
    }

    define config_repo($server_uri, $pkg_name, $pkg_release) {
        exec { "config-repo-${name}":
            command => "yum -y install ${server_uri}/${pkg_name}-${pkg_release}.rpm",
            unless  => "rpm -q ${pkg_name}",
        }
    }

    # Rawhide systems begin life as the latest stable release and should be
    # fully puppetized prior to upgrading to rawhide.  Once there, they have
    # no need for this section, which would only throw errors anyway.
    if $operatingsystemrelease != 'Rawhide' {

        $pub = 'http://mdct-00fs.dartcontainer.com/ftp/pub/fedora'

        config_repo {'local-fedora':
            server_uri  => "$pub/mdct/${operatingsystemrelease}/${architecture}",
            pkg_name    => 'yum-local-mirror-conf',
            pkg_release => $operatingsystemrelease ? {
                '13'    => '13-1.dcc.noarch',
                '14'    => '14-1.dcc.noarch',
                '15'    => '15-1.dcc.noarch',
                '16'    => '16-1.dcc.noarch',
                '17'    => '17-2.dcc.noarch',
                '18'    => '18-2.fc18.noarch',
                '19'    => '19-1.fc19.noarch',
            },
        }

        config_repo {'mdct':
            server_uri  => "$pub/mdct/${operatingsystemrelease}/${architecture}",
            pkg_name    => 'fedora-mdct-release',
            pkg_release => $operatingsystemrelease ? {
                '13'    => '13-1.dcc.noarch',
                '14'    => '14-1.dcc.noarch',
                '15'    => '15-1.dcc.noarch',
                '16'    => '16-1.dcc.noarch',
                '17'    => '17-1.dcc.noarch',
                '18'    => '18-1.fc18.noarch',
                '19'    => '19-1.fc19.noarch',
            },
        }

        config_repo {'rpmfusion-free':
            server_uri  => "$pub/rpmfusion/free/fedora",
            pkg_name    => 'rpmfusion-free-release',
            pkg_release => "$operatingsystemrelease.noarch",
        }

        config_repo {'rpmfusion-nonfree':
            server_uri  => "$pub/rpmfusion/nonfree/fedora",
            pkg_name    => 'rpmfusion-nonfree-release',
            pkg_release => "$operatingsystemrelease.noarch",
            require => Exec['config-repo-rpmfusion-free'],
        }

    }

}

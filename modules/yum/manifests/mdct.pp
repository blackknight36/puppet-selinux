# modules/yum/manifests/mdct.pp

class yum::mdct {

    include 'yum::params'

    # Rawhide systems begin life as the latest stable release and should be
    # fully puppetized prior to upgrading to rawhide.  Once there, they have
    # no need for this section, which would only throw errors anyway.
    if $operatingsystemrelease != 'Rawhide' {

        yum::repo {'mdct':
            server_uri  => "$fedora_repo_uri/mdct/${operatingsystemrelease}/${architecture}",
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

    }

}

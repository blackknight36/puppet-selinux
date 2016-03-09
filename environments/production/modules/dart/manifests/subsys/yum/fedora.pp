# modules/dart/manifests/subsys/yum/fedora.pp

class dart::subsys::yum::fedora {

    include 'dart::subsys::yum::params'

    # Rawhide systems begin life as the latest stable release and should be
    # fully puppetized prior to upgrading to rawhide.  Once there, they have
    # no need for this section, which would only throw errors anyway.
    if $::operatingsystemrelease != 'Rawhide' {

        if $::operatingsystemrelease >= '18' and $::operatingsystem <= '21' {
            $repo_arch = 'noarch'
        } else {
            $repo_arch = $::architecture
        }

		if $::operatingsystemrelease >= '24' {
            fail ("${title}: operating system '${::operatingsystem} ${::operatingsystemrelease}' is not yet supported by puppet.")
        } else {
            $pkg_release = $::operatingsystemrelease ? {
                '13'    => '13-1.dcc.noarch',
                '14'    => '14-1.dcc.noarch',
                '15'    => '15-1.dcc.noarch',
                '16'    => '16-1.dcc.noarch',
                '17'    => '17-2.dcc.noarch',
                '18'    => '18-2.fc18.noarch',
                '19'    => '19-1.fc19.noarch',
                '20'    => '20-4.fc20.noarch',
                '21'    => '21-1.fc21.noarch',
                '22'    => '22-4.fc22.noarch',
                '23'    => '23-1.fc23.noarch',
            }
        }

        if $::operatingsystemrelease >= '22' {
            $server_uri = "${::dart::subsys::yum::params::fedora_repo_uri}/dart/released/${::operatingsystemrelease}/${repo_arch}"
        }
        else {
            $server_uri = "${::dart::subsys::yum::params::fedora_repo_uri}/mdct/${::operatingsystemrelease}/${repo_arch}"
        }

        yum::repo {'local-fedora':
            server_uri  => $server_uri, 
            pkg_name    => 'yum-local-mirror-conf',
            pkg_release => $pkg_release,
        }

    }

}

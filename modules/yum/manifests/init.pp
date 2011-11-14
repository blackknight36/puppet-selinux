# modules/yum/manifests/init.pp

class yum {

    define config_repo($server_uri, $pkg_name, $pkg_release) {
	exec { "config-repo-${name}":
	    command 	=> "rpm -ivh ${server_uri}/${pkg_name}-${pkg_release}.rpm",
	    unless	=> "rpm -q ${pkg_name}",
	}
    }

    $pub = 'http://mdct-00fs.dartcontainer.com/ftp/pub/fedora'

    config_repo {'local-fedora':
	server_uri	=> "$pub/mdct/${operatingsystemrelease}/${architecture}",
	pkg_name	=> 'yum-local-mirror-conf',
	pkg_release	=> $operatingsystemrelease ? {
	    '8' 	=> '8-1.dcc.noarch',
	    '10'	=> '10-2.dcc.noarch',
	    '11'	=> '11-1.dcc.noarch',
	    '12'	=> '12-1.dcc.noarch',
	    '13'	=> '13-1.dcc.noarch',
	    '14'	=> '14-1.dcc.noarch',
	    '15'	=> '15-1.dcc.noarch',
	    '16'	=> '16-1.dcc.noarch',
            },
    }

    config_repo {'mdct':
        server_uri	=> "$pub/mdct/${operatingsystemrelease}/${architecture}",
        pkg_name	=> 'fedora-mdct-release',
        pkg_release	=> $operatingsystemrelease ? {
            '8'		=> '8-1.dcc.noarch',
            '10'	=> '10-3.dcc.noarch',
            '11'	=> '11-1.dcc.noarch',
            '12'	=> '12-1.dcc.noarch',
            '13'	=> '13-1.dcc.noarch',
            '14'	=> '14-1.dcc.noarch',
            '15'	=> '15-1.dcc.noarch',
            '16'	=> '16-1.dcc.noarch',
            },
    }

    # Configure RPM fusion for Fedora 10 and newer.  We don't have this for
    # Fedora 8.
    if $operatingsystemrelease >= 10 {

	config_repo {'rpmfusion-free':
	    server_uri	=> "$pub/rpmfusion/free/fedora/releases/${operatingsystemrelease}/Everything/${architecture}/os/",
	    pkg_name	=> 'rpmfusion-free-release',
	    pkg_release	=> $operatingsystemrelease ? {
		'10'	=> '10-1.noarch',
		'11'	=> '11-1.noarch',
		'12'	=> '12-1.noarch',
		'13'	=> '13-2.noarch',
		'14'	=> '14-0.4.noarch',
		'15'	=> '15-1.noarch',
		'16'	=> '16-1.2.noarch',
		},
	}

	config_repo {'rpmfusion-nonfree':
	    server_uri	=> "$pub/rpmfusion/nonfree/fedora/releases/${operatingsystemrelease}/Everything/${architecture}/os/",
	    pkg_name	=> 'rpmfusion-nonfree-release',
	    pkg_release	=> $operatingsystemrelease ? {
		'10' 	=> '10-1.noarch',
		'11' 	=> '11-1.noarch',
		'12' 	=> '12-1.noarch',
		'13' 	=> '13-2.noarch',
		'14' 	=> '14-0.4.noarch',
		'15' 	=> '15-1.noarch',
		'16' 	=> '16-1.1.noarch',
		},
	    require	=> Exec['config-repo-rpmfusion-free'],
	}

    }

}

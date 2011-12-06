# modules/rpcidmapd/manifests/init.pp

class rpcidmapd {

    package { 'nfs-utils':
	 ensure => installed,
    }

    if $operatingsystem == 'Fedora' and $operatingsystemrelease >= 15 {
        $libnfsidmap_package = 'libnfsidmap'
    } else {
        $libnfsidmap_package = 'nfs-utils-lib'
    }
    package { 'nfs-utils-lib':
	 ensure => installed,
         name   => $libnfsidmap_package,
    }

    file { '/etc/idmapd.conf':
        group   => 'root',
        mode    => 644,
        owner   => 'root',
	require => Package['nfs-utils-lib'],
        source	=> 'puppet:///modules/rpcidmapd/idmapd.conf',
    }

    if $operatingsystem == 'Fedora' and $operatingsystemrelease >= 16 {
        $rpcidmapd_service = 'nfs-idmap'
    } else {
        $rpcidmapd_service = 'rpcidmapd'
    }
    service { 'rpcidmapd':
	enable		=> true,
	ensure		=> running,
	hasrestart	=> true,
	hasstatus	=> true,
        name            => $rpcidmapd_service,
	require		=> [
	    Package['nfs-utils'],
	    Package['nfs-utils-lib'],
	],
	subscribe	=> [
	    File['/etc/idmapd.conf'],
	]
    }

}

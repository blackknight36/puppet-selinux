# modules/autofs/manifests/init.pp

class autofs {

    include authconfig
    include rpcidmapd

    package { "autofs":
	 ensure => installed
    }

    file { "/etc/auto.home":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source  => "puppet:///modules/autofs/auto.home",
    }

    # As of Fedora 13, the policy is more strict and this is required
    # for logins to gain access to the user's home dir, if it is on
    # NFS.  Interestingly, this only affects the cd within login as it
    # is still possible to enter the home dir after login when this is
    # off.
    selinux::boolean { 'use_nfs_home_dirs':
        persistent      => true,
        value           => on,
    }

    if  $operatingsystem == "Fedora" and
        $operatingsystemrelease == 'Rawhide' or
        $operatingsystemrelease >= 16
    {
        $auto_master = 'auto.master.F16+'
    } else {
        $auto_master = 'auto.master'
    }

    file { "/etc/auto.master":
        group   => "root",
        mode    => 644,
        owner   => "root",
	require => Package["autofs"],
        source  => "puppet:///modules/autofs/${auto_master}",
    }

    file { "/etc/auto.mnt":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source	=> "puppet:///modules/autofs/auto.mnt",
    }

    file { "/etc/auto.mnt-local":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source	=> $hostname ? {
            "mdct-dev12"        => "puppet:///modules/autofs/auto.mnt-mdct-dev12",
            "mole"              => "puppet:///modules/autofs/auto.mnt-mole",
            "mdct-dev6"         => "puppet:///modules/autofs/auto.mnt-mdct-dev6",
            "mdct-dev6-test"    => "puppet:///modules/autofs/auto.mnt-mdct-dev6",
            default             => "puppet:///modules/autofs/auto.mnt-local",
        },
    }

    file { "/pub":
	ensure	=> "/mnt/pub",
    }

    service { "autofs":
	enable		=> true,
	ensure		=> running,
	hasrestart	=> true,
	hasstatus	=> true,
	require		=> [
            Exec["authconfig"],
	    File["/pub"],
	    Package["autofs"],
	    Service["rpcidmapd"],
	],
	subscribe	=> [
	    File["/etc/auto.home"],
	    File["/etc/auto.master"],
	    File["/etc/auto.mnt"],
	    File["/etc/auto.mnt-local"],
	]
    }

}

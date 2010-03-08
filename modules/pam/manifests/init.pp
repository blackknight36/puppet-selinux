# /etc/puppet/modules/pam/manifests/init.pp

class pam {

    if $operatingsystem == "Fedora" {

	package { "pam":
	    ensure	=> installed,
	}

	file { "/etc/pam.d/system-auth-ac":
	    group	=> "root",
	    mode	=> 644,
	    owner	=> "root",
	    require	=> Package["pam"],
	    source	=> $operatingsystemrelease ? {
		"10"    => "puppet:///pam/system-auth-ac.10",
		default	=> "puppet:///pam/system-auth-ac.11",
	    }
	}

    }

}

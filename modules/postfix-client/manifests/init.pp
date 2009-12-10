# /etc/puppet/modules/postfix-client/manifests/init.pp

class postfix-client {

    package { "postfix":
	ensure	=> installed,
    }

    package { "sendmail":
	ensure	=> absent,
	# Many packages require a MTA, so make sure postfix is installed before
	# trying to remove sendmail.
        require => Package["postfix"],
    }

    file { "/etc/postfix/main.cf":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["postfix"],
        source  => "puppet:///postfix-client/main.cf",
    }

    mailalias { "root":
	ensure		=> present,
	recipient	=> "jflorian@doubledog.org",
        require 	=> Package["postfix"],
    }

    service { "postfix":
	enable		=> true,
	ensure		=> running,
	hasrestart	=> true,
	hasstatus	=> true,
	require		=> [
	    Package["postfix"],
	    Package["sendmail"],
	],
	subscribe	=> [
	    File["/etc/postfix/main.cf"],
	]
    }

}

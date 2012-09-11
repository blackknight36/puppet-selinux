# modules/puppet/manifests/client.pp

class puppet::client {

    package { "puppet":
	ensure	=> installed,
    }

    $scary = "$fqdn is running puppet-$puppetversion atop $operatingsystem $operatingsystemrelease.  Versions 2.6.6 and prior are poorly supported and quite buggy.  Please upgrade!"
    if versioncmp($puppetversion, "2.6") < 0 {
        $puppet_era = "pre-2.6"
        warning "$scary"
    } elsif versioncmp($puppetversion, "2.6.6") > 0 {
        $puppet_era = "after-2.6.6"
    } else {
        $puppet_era = "as-of-2.6"
        warning "$scary"
    }

    file { "/etc/puppet/puppet.conf":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        require => Package["puppet"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "puppet_etc_t",
        source  => [
            "puppet:///private-host/puppet/puppet.conf",
            "puppet:///modules/puppet/puppet.conf.${puppet_era}",
        ],
    }

    service { "puppet":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["puppet"],
        ],
        subscribe	=> [
            File["/etc/puppet/puppet.conf"],
        ],
    }

}

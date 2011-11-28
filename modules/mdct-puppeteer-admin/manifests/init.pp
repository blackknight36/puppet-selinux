# modules/mdct-puppeteer-admin/manifests/init.pp

class mdct-puppeteer-admin {

    $SELF='mdct-puppeteer-admin'

    package { "${SELF}":
	ensure	=> installed,
    }

    file { "/etc/${SELF}/${SELF}.conf":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        require => Package["${SELF}"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "etc_t",
        source  => [
            "puppet:///private-host/${SELF}/${SELF}.conf",
            "puppet:///modules/${SELF}/${SELF}.conf",
        ],
    }

}

# modules/mdct_puppeteer_admin/manifests/init.pp

class mdct_puppeteer_admin {

    $SELF='mdct-puppeteer-admin'

    package { "${SELF}":
        ensure  => installed,
    }

    file { "/etc/${SELF}/${SELF}.conf":
        group   => "root",
        mode    => "0644",
        owner   => "root",
        require => Package["${SELF}"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "etc_t",
        source  => [
            "puppet:///private-host/mdct_puppeteer_admin/${SELF}.conf",
            "puppet:///modules/mdct_puppeteer_admin/${SELF}.conf",
        ],
    }

}

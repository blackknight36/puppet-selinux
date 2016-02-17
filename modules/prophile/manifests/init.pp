# modules/prophile/manifests/init.pp
#
# == Class: prophile
#
# Configures a host for prophile usage.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class prophile {

    package { 'prophile':
        ensure  => installed,
    }

    file { '/etc/profile.d/prophiles.sh':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => "alias jf='source prophile jflorian' 2>/dev/null\n",
    }

}

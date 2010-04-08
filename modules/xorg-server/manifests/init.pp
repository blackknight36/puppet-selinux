# /etc/puppet/modules/xorg-server/manifests/init.pp

class xorg-server {

    if ( $hostname == "mdct-dev12" ) {
        file { "/etc/X11/xorg.conf":
            group       => "root",
            mode        => 644,
            owner       => "root",
            source      => "puppet:///xorg-server/xorg.conf.$hostname",
        }
    }

}

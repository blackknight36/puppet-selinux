# modules/xorg-server/manifests/init.pp

class xorg-server($drivers=undef, $config=undef) {

    if $drivers != undef {
        package { $drivers:
            ensure  => installed,
        }
    }

    if $config != undef {
        file { '/etc/X11/xorg.conf':
            owner   => 'root',
            group   => 'root',
            mode    => 0644,
            source  => $config,
        }
    }

}

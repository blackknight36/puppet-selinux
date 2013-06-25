# modules/dart/manifests/mdct-dev9.pp

class dart::mdct-dev9 inherits dart::abstract::workstation_node {

    class { 'xorg-server':
        config  => "puppet:///private-host/etc/X11/xorg.conf",
        drivers => ['kmod-nvidia-304xx'],
    }

    include jetbrains::idea
    include packages::kde
    include yum-cron

}

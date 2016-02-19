# modules/dart/manifests/mdct_dev12/aos_nightlies.pp
#
# == Class: dart::mdct_dev12::aos_nightlies
#
# Build nightly AOS images based on the latest packages from the Dart Testing
# and Fedora Updates repositories.
#
# === Parameters
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12::aos_nightlies {

    # These parameters affect the auto-build-iso script.
    $archives = '/pub/fedora/aos/iso/nightlies'
    $keep_days = 14
    $aos_build_name = 'nunki'
    $target = 'f21'

    file { '/usr/local/bin/auto-build-iso':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'bin_t',
        content => template('dart/builder/auto-build-iso'),
    } ->

    ::cron::job { 'auto-build-iso':
        # build-iso has to be launched oddly like this because it runs the
        # koji CLI and some subcommands (like spin-livecd) go into a "quiet"
        # mode because stdin is not a tty.  If quiet like this, build-iso will
        # not be able to capture task IDs as it must from the koji output.
        command => 'nice ionice -c 3 python3 -c \'import pty; pty.spawn("/usr/local/bin/auto-build-iso")\'',
        user    => 'd13677',
        minute  => 44,
        hour    => 22,
        dow     => 'Mon-Fri',
        mailto  => 'john.florian@dart.biz',
    }

}

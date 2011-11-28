# modules/packages/manifests/classes/base.pp

class packages::base {

    ### Universal Package Inclusion ###

    package { [

        'apt',
        'bash-completion',
        'expect',
        'gparted',
        'gpm',
        'iotop',
        'lsof',
        'mlocate',
        'multitail',
        'openssh-clients',
        'pciutils',
        'policycoreutils-python',       # provides audit2allow and audit2why
        'prophile',
        'python-mdct',
        'ruby-rdoc',
        'screen',
        'strace',
        'task',
        'tree',
        'units',
        'usbutils',
        'vim-X11',
        'vim-enhanced',
        'xorg-x11-xauth',               # xauth required for X11 forwarding
        'yum-utils',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $operatingsystem == 'Fedora' {

        if $operatingsystemrelease >= 11 {
            package { [
                'dejavu-lgc-sans-mono-fonts',   # used by vim-X11
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'dejavu-lgc-fonts',             # used by vim-X11
                ]:
                ensure => installed,
            }
        }

        if $operatingsystemrelease >= 13 {
            package { [
                'cifs-utils',
                ]:
                ensure  => installed,
            }
        }

        if $operatingsystemrelease >= 14 {
            package { [
                'man-db',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'man',
                ]:
                ensure => installed,
            }
        }

        if $architecture == 'x86_64' and
           $operatingsystemrelease > 8 and
           $operatingsystemrelease <= 11 {
            include packages::compat_32bit
        }

    }

    ### Universal Package Exclusion ###

    package { [

        ]:
        ensure => absent,
    }

    # Kludging around puppet's inability to remove deps,
    # system-config-keyboard in this case.
    exec { 'yum -y remove firstboot':
        onlyif  => 'rpm -q firstboot',
    }

    ### Select Package Exclusion ###

    if $operatingsystem == 'Fedora' {

        if $operatingsystemrelease >= 12 {
            package { [
                'yum-presto',   # we don't use delta RPM support
                ]:
                ensure => absent,
            }
        }

        if $operatingsystemrelease >= 14 {
            package { [
                'PackageKit-yum-plugin', # not used and slows yum startup
                ]:
                ensure => absent,
            }
        }

    }

}

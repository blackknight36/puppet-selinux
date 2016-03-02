# modules/dart/manifests/abstract/packages/base.pp

class dart::abstract::packages::base {

    ### Universal Package Inclusion ###

    package { [

        'apt',
        'bash-completion',
        'expect',
        'fuse-sshfs',
        'gparted',
        'gpm',
        'iotop',
        'lsof',
        'mlocate',
        'multitail',
        'openssh-clients',
        'pciutils',
        'psmisc',
        'screen',
        'strace',
        'system-config-printer',
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

    if $::operatingsystem == 'Fedora' {

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= '11'
        {
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

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= '13'
        {
            package { [
                'cifs-utils',
                ]:
                ensure  => installed,
            }
        }

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= '14'
        {
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

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= '16'
        {
            package { [
                'sssd-tools',
                ]:
                ensure => installed,
            }
        }

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= '17'
        {
            package { [
                'rubygem-rdoc',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'ruby-rdoc',
                ]:
                ensure => installed,
            }
        }

    }

    ### Universal Package Exclusion ###

    package { [

        ]:
        ensure => absent,
    }

    # Kludging around puppet's inability to remove deps,
    # system-config-keyboard in this case.
    yum::remove {
        'firstboot':;
        'gnome-initial-setup':;
    }

    ### Select Package Exclusion ###

    if $::operatingsystem == 'Fedora' {
      if $::operatingsystemrelease >= '12' and $::operatingsystemrelease <= '21' {
        package { 'yum-presto':
          ensure => absent,
        }
      }
      elsif $::operatingsystemrelease == 'Rawhide' {
        package { 'yum-presto':
          ensure => absent,
        }
      }
      if $::operatingsystemrelease >= '14' and $::operatingsystemrelease <= '21' {
        package {'PackageKit-yum-plugin':
          ensure => absent,
        }
      }
      elsif $::operatingsystemrelease == 'Rawhide' {
        package {'PackageKit-yum-plugin':
          ensure => absent,
        }
      }
    }
}

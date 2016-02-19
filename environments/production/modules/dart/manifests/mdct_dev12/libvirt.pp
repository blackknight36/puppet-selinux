# modules/dart/manifests/mdct_dev12/libvirt.pp
#
# == Class: dart::mdct_dev12::libvirt
#
# Manages libvirt on John Florian's workstation.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12::libvirt {

    $SUFFIX=".orig-${::operatingsystem}${::operatingsystemrelease}"

    Dart::Util::Replace_original_with_symlink_to_alternate {
        before      => Service['libvirtd'],
        notify      => Service['libvirtd'],
        require     => Package['libvirt'],
    }

    dart::util::replace_original_with_symlink_to_alternate { '/etc/libvirt':
        alternate => '/mnt/storage/etc/libvirt',
        backup    => "/etc/libvirt${SUFFIX}",
        original  => '/etc/libvirt',
        seltype   => 'virt_etc_t',
    }

    dart::util::replace_original_with_symlink_to_alternate { '/var/lib/libvirt':
        alternate => '/mnt/storage/var/lib/libvirt',
        backup    => "/var/lib/libvirt${SUFFIX}",
        original  => '/var/lib/libvirt',
        seltype   => 'virt_var_lib_t',
    }

    service {
        'libvirtd':
            ensure      => running,
            enable      => true,
            hasrestart  => true,
            hasstatus   => true;

        # Prefer forced power off as it's much faster than suspending.
        'libvirtd-guests':
            ensure      => stopped,
            enable      => false,
            hasrestart  => true,
            hasstatus   => true;
    }

}

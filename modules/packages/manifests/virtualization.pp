# modules/packages/manifests/virtualization.pp

class packages::virtualization {

    ### Universal Package Inclusion ###

    package { [

        'libvirt',
        'virt-manager',
        'virt-viewer',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $operatingsystem == 'Fedora' {

        if $operatingsystemrelease >= 11 {
            package { [
                'qemu-kvm',
                ]:
                ensure => installed,
            }
        } else {
            package { [
                'kvm',
                'qemu',
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

    ### Select Package Exclusion ###

    # none

}

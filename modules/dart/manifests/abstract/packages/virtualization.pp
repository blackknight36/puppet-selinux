# modules/dart/manifests/abstract/packages/virtualization.pp

class dart::abstract::packages::virtualization {

    ### Universal Package Inclusion ###

    package { [

        'libvirt',
        'virt-manager',
        'virt-viewer',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $::operatingsystem == 'Fedora' {

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 19
        {
            package { [
                'virt-install',
                ]:
                ensure => installed,
            }
        }

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 17
        {
            package { [
                'libvirt-daemon-kvm',
                ]:
                ensure => installed,
            }
        }

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 11
        {
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

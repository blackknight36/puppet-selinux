# /etc/puppet/modules/packages/manifests/classes/virtualization.pp

class packages::virtualization {

    if ( $operatingsystem == "Fedora" ) and ($operatingsystemrelease < 11) {
        package { "kvm":
            ensure	=> installed,
        }
        package { "qemu":
            ensure	=> installed,
        }
    }
    else {
        package { "qemu-kvm":
            ensure	=> installed,
        }
    }

    package { "libvirt":
	ensure	=> installed,
    }

    package { "virt-manager":
	ensure	=> installed,
    }

    package { "virt-viewer":
	ensure	=> installed,
    }

}

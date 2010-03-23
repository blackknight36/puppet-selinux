# /etc/puppet/modules/pkgs_virtualization/manifests/init.pp

class pkgs_virtualization {

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

    package { "virt-manager":
	ensure	=> installed,
    }

    package { "virt-viewer":
	ensure	=> installed,
    }

}

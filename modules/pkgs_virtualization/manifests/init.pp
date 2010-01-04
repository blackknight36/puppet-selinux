# /etc/puppet/modules/pkgs_virtualization/manifests/init.pp

class pkgs_virtualization {

    package { "qemu-kvm":
	ensure	=> installed,
    }

    package { "virt-manager":
	ensure	=> installed,
    }

    package { "virt-viewer":
	ensure	=> installed,
    }

}

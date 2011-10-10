# modules/samba/manifests/classes/samba.pp
#
# Synopsis:
#       Establish a SMB/CIFS service.
#
# NB:
#       On systems with SELinux enabled, you will need to do the following on
#       your top-level shares prior to populating them:
#
#               chcon -t samba_share_t /storage/share_top/

class samba {

    include lokkit

    package { 'samba':
	ensure	=> installed,
    }

    file { '/etc/samba/smb.conf':
        group	=> 'root',
        mode    => '0640',
        owner   => 'root',
        require => Package['samba'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'samba_etc_t',
        source  => [
            'puppet:///private-host/samba/smb.conf',
            'puppet:///modules/samba/smb.conf',
        ],
    }

    lokkit::tcp_port { 'netbios-ssn':
        port    => '139',
    }

    lokkit::tcp_port { 'microsoft-ds':
        port    => '445',
    }

    selboolean { 'samba_export_all_ro':
        persistent      => true,
        value           => on,
    }

    selboolean { 'samba_export_all_rw':
        persistent      => true,
        value           => on,
    }

    service { 'smb':
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec['open-microsoft-ds-tcp-port'],
            Exec['open-netbios-ssn-tcp-port'],
            Package['samba'],
            Selboolean['samba_export_all_ro'],
            Selboolean['samba_export_all_rw'],
        ],
        subscribe	=> [
            File['/etc/samba/smb.conf'],
        ],
    }

}

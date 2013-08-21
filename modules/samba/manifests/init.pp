# modules/samba/manifests/init.pp
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

    package { 'samba':
        ensure  => installed,
    }

    file { '/etc/samba/smb.conf':
        group   => 'root',
        mode    => '0640',
        owner   => 'root',
        require => Package['samba'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'samba_etc_t',
        source  => [
            'puppet:///private-host/samba/smb.conf',
            'puppet:///private-domain/samba/smb.conf',
            'puppet:///modules/samba/smb.conf',
        ],
    }

    lokkit::tcp_port {
        'netbios-ssn':
            port    => '139';
        'microsoft-ds':
            port    => '445';
    }

    selinux::boolean {
        'samba_export_all_ro':
            before          => Service['smb'],
            persistent      => true,
            value           => on;
        'samba_export_all_rw':
            before          => Service['smb'],
            persistent      => true,
            value           => on;
    }

    service { 'smb':
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => Package['samba'],
        subscribe   => File['/etc/samba/smb.conf'],
    }

}

# /etc/puppet/modules/samba/manifests/classes/samba.pp
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

    package { "samba":
	ensure	=> installed,
    }

    file { "/etc/samba/smb.conf":
        group	=> "root",
        mode    => "0640",
        owner   => "root",
        require => Package["samba"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "samba_etc_t",
        source  => [
            "puppet:///private-host/samba/smb.conf",
            "puppet:///modules/samba/smb.conf",
        ],
    }

    exec { "open-netbios-ssn-port":
        command => "lokkit --port=139:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 139 -j ACCEPT' /etc/sysconfig/iptables",
    }

    exec { "open-microsoft-ds-port":
        command => "lokkit --port=445:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 445 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "smb":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-netbios-ssn-port"],
            Exec["open-microsoft-ds-port"],
            Package["samba"],
        ],
        subscribe	=> [
            File["/etc/samba/smb.conf"],
        ],
    }

}

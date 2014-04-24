# modules/dart/manifests/mdct_00pi.pp
#
# Synopsis:
#       PICAPS live server for Corporate
#
# Contact:
#       Chris Kennedy

class dart::mdct_00pi inherits dart::abstract::picaps_production_server_node {

    class { 'network':
        service         => 'legacy',
        domain          => 'dartcontainer.com',
        name_servers    => ['10.1.0.98', '10.1.0.99'],
    }

#    network::interface { 'em1':
#        template    => 'static',
#        ip_address  => '10.1.192.149',
#        netmask     => '255.255.0.0',
#        gateway     => '10.1.0.25',
#    }

    autofs::map_entry { '/mnt/prodmondata':
        mount   => '/mnt',
        key     => 'prodmondata',
        options => '-fstype=cifs,rw,credentials=/etc/.credentials/mdcgate.cred',
        remote  => '://mas-fs01/ProdMonData',
    }
    autofs::map_entry { '/mnt/sm2ci00v-miisbx':
        mount   => '/mnt',
        key     => 'sm2ci00v-miisbx',
        options => '-fstype=cifs,rw,credentials=/etc/.credentials/mas_mdc.cred',
        remote  => '://sm2ci00v/miisbx',
    }
    file { '/etc/.credentials':
        owner   => 'root',
        group   => 'root',
        mode    => '0750',
        ensure  => 'directory',
        before  => File['/etc/.credentials/mdcgate.cred'],
        before  => File['/etc/.credentials/mas_mdc.cred'],
    }
    file { "/etc/.credentials/mdcgate.cred":
        group   => "root",
        mode    => 600,
        owner   => "root",
        source  => [
            'puppet:///modules/dart/picaps_servers/mdcgate.cred',
        ],
        before  => Autofs::Map_entry['/mnt/prodmondata'],
    }
    file { "/etc/.credentials/mas_mdc.cred":
        group   => "root",
        mode    => 600,
        owner   => "root",
        source  => [
            'puppet:///modules/dart/picaps_servers/mas_mdc.cred',
        ],
        before  => Autofs::Map_entry['/mnt/sm2ci00v-miisbx'],
    }
    file { "/dist/reportoutput":
        ensure  => link,
        target  => "/mnt/prodmondata/staging",
    }
    file { "/dist/mii":
        ensure  => link,
        target  => "/mnt/sm2ci00v-miisbx/MII",
    }
}

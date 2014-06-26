# modules/dart/manifests/abstract/packages/net_tools.pp

class dart::abstract::packages::net_tools {

    include 'tsocks'

    ### Universal Package Inclusion ###

    package { [

        'bind-utils',
        'bridge-utils',
        'conntrack-tools',
        'enmasse',
        'ethtool',
        'ipcalculator',
        'mtr',
        'netstat-nat',
        'nmap',
        'openldap-clients',
        'tcpdump',
        'telnet',
        'wireshark-gnome',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    # none

    ### Universal Package Exclusion ###

    package { [

        ]:
        ensure => absent,
    }

    ### Select Package Exclusion ###

    # none

}

# modules/dart/manifests/abstract/packages/net_tools.pp

class dart::abstract::packages::net_tools {

    include 'tsocks'

    ### Universal Package Inclusion ###

    package { [

        'bind-utils',
        'bridge-utils',
        'conntrack-tools',
        'ethtool',
        'mtr',
        'nmap',
        'openldap-clients',
        'tcpdump',
        'telnet',
        'wireshark-gnome',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $::operatingsystem != 'CentOS' {
        package { [
            'enmasse',
            'ipcalculator',
            'netstat-nat',
            ]:
            ensure => installed,
        }
    }

    # none

    ### Universal Package Exclusion ###

    package { [

        ]:
        ensure => absent,
    }

    ### Select Package Exclusion ###

    # none

}

# modules/dart/manifests/abstract/workstation_node.pp

class dart::abstract::workstation_node inherits dart::abstract::base_node {

    include 'dart::abstract::packages::developer'
    include 'dart::abstract::packages::media'
    include 'dart::abstract::packages::net_tools'
    include 'dart::abstract::packages::virtualization'
    include 'dart::abstract::packages::workstation'
    include 'dart::subsys::autofs::common'
    include 'dart::unwanted_services'
    include 'flock_herder'

    class { 'iptables':
        enabled => true,
    }

    # Lotus Notes has been disabled for now due to poor functioning.
    #include 'lotus_notes_client'

    include 'test_automation'

    class { 'dart::subsys::yum::rpmfusion':
        require => Class['yum'],
        stage   => 'first',
    }

}

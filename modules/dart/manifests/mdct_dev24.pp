# modules/dart/manifests/mdct_dev24.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Daniel Brown


class dart::mdct_dev24 inherits dart::abstract::workstation_node {

    class { '::network':
        service      => 'nm',
        domain       => $dart::params::dns_domain,
        name_servers => $dart::params::dns_servers,
    }

    network::interface {
        'br0':
            template   => 'static-bridge',
            ip_address => '10.1.250.186',
            netmask    => '255.255.0.0',
            gateway    => '10.1.0.25',
            stp        => 'no',
            mac_address => '0e:00:0d:85:70:15',
            ;

        'eno1':
            template => 'static',
            bridge   => 'br0',
            ;
    }

    include '::dart::abstract::idea'
    include '::dart::abstract::pycharm::community'
    include '::dart::subsys::koji::autofs'
    include '::dart::subsys::koji::cli'
    include '::dart::subsys::yum_cron'

}

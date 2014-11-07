# modules/dart/manifests/mdct_est_dev2.pp
#
# Synopsis:
#       EST testing and development environment
#
# Contact:
#       Ben Minshall

class dart::mdct_est_dev2 inherits dart::abstract::est_server_node {
    iptables::rules_file { 'est-nat':
        content => template('dart/iptables/est-nat.erb'),
        table   => 'nat',
    }

}

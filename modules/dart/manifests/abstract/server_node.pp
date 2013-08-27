# modules/dart/manifests/abstract/server_node.pp
#
# Notes:
#       When possible, it's advisable to use one of the following (listed in
#       order of preference) instead of dart::abstract::server_node:
#
#           Class                                       SELinux     iptables
#           ----------------------------------------    ---------   --------
#           dart::abstract::guarded_server_node         enforcing   enabled
#           dart::abstract::semi_guarded_server_node    disabled    enabled
#           dart::abstract::unguarded_server_node       disabled    disabled


class dart::abstract::server_node inherits dart::abstract::base_node {

    include 'packages::net_tools'

    # Servers typically benefit from showing their boot details.
    class { 'plymouth':
        theme   => 'details',
    }

}

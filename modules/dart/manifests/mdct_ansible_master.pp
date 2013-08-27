# modules/dart/manifests/mdct_ansible_master.pp
#
# Synopsis:
#       Ansible control master (prototype & education)
#
# Contact:
#       John Florian

class dart::mdct_ansible_master inherits dart::abstract::guarded_server_node {

    class { 'puppet::client':
    }

}

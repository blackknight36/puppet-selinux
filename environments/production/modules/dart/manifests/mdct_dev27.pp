# modules/dart/manifests/mdct_dev27.pp
#
# Synopsis:
#       DevOps Workstation
#
# Contact:
#       Michael Watters

class dart::mdct_dev27 inherits dart::abstract::workstation_node {

    class {'collectd::client':
        enable => false,
    }

    package{['thunderbird', 'keepassx', 'qterminal', 'ddrescue', 'autokey-gtk', 'mc', 'most', 'vim-nerdtree']:
        ensure => latest,
    }

}

# modules/dart/manifests/mdct_dev27.pp
#
# Synopsis:
#       DevOps Workstation
#
# Contact:
#       Michael Watters

class dart::mdct_dev27 inherits dart::abstract::workstation_node {
    exec{'install-xfce':
        unless  => '/usr/bin/dnf group list "Xfce Desktop" | /bin/grep "^Installed environment groups"',
        command => 'dnf -y group install "Xfce Desktop"',
    }

    package{['thunderbird', 'keepassx', 'qterminal', 'ddrescue', 'autokey-gtk', 'mc', 'most']:
        ensure => latest,
    }

}

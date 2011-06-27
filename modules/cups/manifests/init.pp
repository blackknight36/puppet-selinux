# /etc/puppet/modules/cups/manifests/init.pp

class cups {

    package { "cups":
	ensure	=> installed,
    }

# Not doing any management of print queues, classes, etc. via puppet at this
# time due to races with cupsd which, most annoyingly, finds it necessary to
# rewrite its config files with a time stamped header affixed.  Long term
# solution would be to use lpadmin(8) to configure print queues.
#
#   file { "/etc/cups/classes.conf":
#       group	=> "lp",
#       mode    => 600,
#       owner   => "root",
#       require => Package["cups"],
#       source  => "puppet:///cups/classes.conf",
#   }

#   file { "/etc/cups/ppd/brother.ppd":
#       group	=> "root",
#       mode    => 644,
#       owner   => "root",
#       require => Package["cups"],
#       source  => "puppet:///cups/brother.ppd",
#   }

#   file { "/etc/cups/printers.conf":
#       group	=> "lp",
#       mode    => 600,
#       owner   => "root",
#       require => Package["cups"],
#       source  => "puppet:///cups/printers.conf",
#   }

#   file { "/etc/cups/subscriptions.conf":
#       group	=> "lp",
#       mode    => 640,
#       owner   => "root",
#       require => Package["cups"],
#       source  => "puppet:///cups/printers.conf",
#   }

    exec { "open-cups-port":
        command => "lokkit --port=631:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 631 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "cups":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-cups-port"],
            Package["cups"],
        ],
# See comment above.
#       subscribe	=> [
#           File["/etc/cups/classes.conf"],
#           File["/etc/cups/ppd/brother.ppd"],
#           File["/etc/cups/printers.conf"],
#           File["/etc/cups/subscriptions.conf"],
#       ]
    }

}

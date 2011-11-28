# modules/cups/manifests/init.pp

class cups {

    include lokkit

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

    lokkit::tcp_port { "cups":
        port    => "631",
    }

    service { "cups":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-cups-tcp-port"],
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

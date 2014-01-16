# modules/dart/manifests/mdct-00sw.pp
#
# Synopsis:
#       Shared Workstation
#
# Contact:
#       John Florian

class dart::mdct_00sw inherits dart::abstract::workstation_node {

    include 'dart::subsys::yum_cron'

    include 'vnc::server'

    vnc::display_config { 'Bill Eltzroth':
        display_num     => 2,
        user            => 'd9744',
        password        => 'mdct/vnc',
        geometry        => '1600x900',
    }

    vnc::display_config { 'Koua Vue':
        display_num     => 3,
        user            => 'd24024',
        password        => 'mdct/vnc',
        geometry        => '1600x900',
    }

    # Repeat as necessary for additional user sessions.
    #   vnc::display_config { 'Yosemite Sam':
    #       display_num     => 3,
    #       user            => 'd12345',
    #       password        => 'mdct/vnc',
    #   }

}

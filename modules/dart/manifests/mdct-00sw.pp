# modules/dart/manifests/classes/mdct-00sw.pp

class dart::mdct-00sw inherits dart::abstract::workstation_node {

    include packages::kde
    include yum-cron

    include vnc::server

    vnc::display-config { 'Roger Brunk':
        display_num     => 1,
        user            => 'd33576',
        password        => 'mdct/vnc',
    }

    # Repeat as necessary for additional user sessions.
    #   vnc::display-config { 'Yosemite Sam':
    #       display_num     => 2,
    #       user            => 'd12345',
    #       password        => 'mdct/vnc',
    #   }


}

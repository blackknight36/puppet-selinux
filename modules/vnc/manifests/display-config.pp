# modules/vnc/manifests/display-config.pp
#
# Synopsis:
#       Configures a VNC display for a single user session.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            session name, mostly for puppet reports
#       ensure          present         configuration is to be absent/present
#       display_num                     X11 display number to be used, e.g. '1'
#       user                            X11 session owner
#       password                        plain-text password for session access
#
# Requires:
#       Class['systemd']
#
# Bugs/Quirks:
#       The 'ensure' parameter is not yet fully supported and only the
#       'present' state is correctly handled.  With 'absent', the systemd
#       service will be disabled and stopped, but the firewall port will
#       remain open and the VNC session password will be left intact.
#
# Example usage:
#
#       include systemd
#       include vnc
#
#       vnc::display-config { 'acme':
#           notify  => Service['SERVICE_NAME'],
#           source  => 'puppet:///private-host/acme.conf',
#       }


define vnc::display-config ($ensure='present', $display_num, $user, $password,
                            $geometry='1024x768'
    ) {

    $display = ":${display_num}"

    # NB: runuser is employed here to work around a puppet bug that prevents
    # using a much simpler approach with exec's "user" parameter. Reference:
    # http://projects.puppetlabs.com/issues/11364
    #
    # TODO: handle ensure='absent' sense appropriately.
    #
    exec { "set vncserver password $display":
        command => "runuser -l $user -c \"mkdir -p ~/.vnc; umask 0077 && echo $password | vncpasswd -f > ~/.vnc/passwd\"",
        require => Package['tigervnc-server-minimal'],
        unless  => "runuser -l $user -c \"test -e ~/.vnc/passwd\"",
    }

    systemd::unit { "vncserver${display}.service":
        content => template('vnc/vncserver.service'),
        ensure  => $ensure,
        require => Exec["set vncserver password $display"],
    }


    # TODO: handle ensure='absent' sense appropriately.
    #
    $vncserver_port = 5900 + $display_num
    lokkit::tcp_port { "vncserver${display}":
        port    => $vncserver_port,
    }

}

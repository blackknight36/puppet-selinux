# modules/vnc/manifests/server.pp
#
# Synopsis:
#       Configures a host for serving VNC sessions.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE
#
# Example usage:
#
#       include vnc::server

class vnc::server {

    include lokkit

    package { 'tigervnc-server-minimal':
	ensure	=> installed,
    }

    package { 'tigervnc-server':
	ensure	=> installed,
        require => Package['tigervnc-server-minimal'],
    }

}

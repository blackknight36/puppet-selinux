# modules/systemd/manifests/init.pp
#
# Synopsis:
#       Configures a host for running systemd.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE
#
# Example usage:
#
#       include systemd

class systemd {

    package { 'systemd':
	ensure	=> installed,
    }

}

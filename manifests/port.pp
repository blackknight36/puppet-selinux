# Synopsis:
#       Configures a SELinux port context.
#
# Parameters:
#
# Requires:
#       Class['selinux']
#
# Example usage:
#
#       include 'selinux'
#
#       selinux::port { 'pagure_ev':
#           port => 8088,
#           seltype => 'http_port_t'
#       }

define selinux::port (
    Integer $port,
    String  $seltype,
    Variant[String, Enum['present', 'absent']] $ensure = 'present',
    Variant[String, Enum['tcp', 'udp']] $proto = 'tcp',
    ) {

    case $ensure {
        'present': {
            $command = "semanage port -a -t ${seltype} -p ${proto} ${port}"
            $unless = "semanage port -l | grep -qw ${port}"
            $onlyif = undef
        }

        'absent': {
            $command = "semanage port -d -t ${seltype} -p ${proto} ${port}"
            $unless = undef
            $onlyif = "semanage port -l | grep -qw ${port}"
        }
    }

    exec { $command:
        path   => '/bin:/usr/bin:/usr/sbin',
        unless => $unless,
        onlyif => $onlyif,
    }

}

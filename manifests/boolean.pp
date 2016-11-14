# modules/selinux/manifests/boolean.pp
#
# Synopsis:
#       Configures a SELinux boolean setting.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            SELinux boolean setting name
#       persistent      false           Should change persist through reboot?
#       value                           'on' (enable) or 'off' (disable)
#                                       true, false, 0, or 1 will be converted to to 'on' or 'off'
# Requires:
#       Class['selinux']
#
# Example usage:
#
#       include 'selinux'
#
#       selinux::boolean { 'httpd_use_nfs':
#           persistent => true,
#           value      => on,
#       }
#
#       ...
#
#       # Note the different resource name!  Puppet does not (yet, at least)
#       # permit reference to a definition instance.
#       service { 'httpd':
#           require => Selboolean['httpd_use_nfs'],
#       }
#


define selinux::boolean ($value, $persistent=false) {

    if $::selinux_simple == true {
        case $value {
            true, 1: { $bool_value = 'on' }
            false, 0: { $bool_value = 'off' }
            'on': { $bool_value = 'on' }
            'off': { $bool_value = 'off' }
            default: { 'on' }
        }

        selboolean { $name:
            persistent => $persistent,
            value      => $bool_value,
        }
    }

}

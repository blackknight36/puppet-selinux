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
#
# Requires:
#       Class['selinux']
#
# Example usage:
#
#       include selinux
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


define selinux::boolean ($persistent=false, $value) {

    # puppet might raise errors if selinux is disabled.  For more details see:
    # https://projects.puppetlabs.com/issues/9054
    if $selinux_simple == 'true' {
        selboolean { "$name":
            persistent      => $persistent,
            value           => $value,
        }
    }

}

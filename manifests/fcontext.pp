# modules/selinux/manifests/fcontext.pp
#
# Warning:
#       Work in Progress !!!
#
# Synopsis:
#       Manage a SELinux file context.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            SELinux fcontext setting name
#       persistent      false           Should change persist through reboot?
#       value                           'on' (enable) or 'off' (disable)
#
# Requires:
#       Class['selinux']
#
# Example usage:
#
#       include 'selinux'
#
#       selinux::fcontext { 'httpd_use_nfs':
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


define selinux::fcontext ($type) {

    $semanage='/usr/sbin/semanage'

    exec { "${semanage} fcontext -a -t \"${type}\" \"${name}\"":
        require => Class['selinux'],
        # NB: This is weak and could easily get wrong matches.
        # More work is needed to see if File resource would be sufficient.
        unless  => "${semanage} fcontext -l | grep -q '^${name}.*${type}'",
    }

}

# modules/selinux/manifests/fcontext.pp
#
#Synopsis:
#     Manage SELinux file contexts.
#
# === Parameters
#
# ==== Optional
# [*type*]
#   The file context type to add.  Defaults to default_t.
#
# [*path*]
#   Path for the file context to be created.  Defaults to $name.
#
# Requires:
#       Class['selinux']
#
# === Authors
#
#   John Florian <john.florian@dart.biz>#
#   Michael Watters <michael.watters@dart.biz>
#
# Example usage:
#
#       selinux::fcontext { '/home/cvsroot(/.*)?':
#           type => 'cvs_data_t',
#       }


define selinux::fcontext ($type='default_t') {

    $semanage='/usr/sbin/semanage'

    exec { "${semanage} fcontext -a -t \"${type}\" \"${name}\"":
        require => Class['selinux'],
        # NB: This is weak and could easily get wrong matches.
        # More work is needed to see if File resource would be sufficient.
        unless  => "${semanage} fcontext -l | grep -q '^${$name}.*${type}'",
    }

}

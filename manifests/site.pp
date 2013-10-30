# manifests/site.pp

import "nodes"

# The filebucket option allows for file backups to the server
filebucket { "main":
    server  => "puppet.dartcontainer.com",
}

# Establish run stages as: FIRST precedes EARLY precedes MAIN precedes FINAL
stage { 'first':
    before  => Stage['early'],
}
stage { 'early':
    before  => Stage['main'],
    require => Stage['first'],
}
stage { 'final':
    require => Stage['main'],
}

#
# Associate classes with run stages (instead of the default Stage['main']).
#

# Why?  Most classes install packages and many create user/group accounts and
# the authconfig class lowers the default min_id value.  Doing authconfig
# early ensures that these new accounts fall below the min_id.
if $hostname != 'mdct-00fs' {
    class { 'authconfig':
        stage => 'early';
    }
    # Why?  Much for the same reason as authconfig.  Not entirely certain this is
    # necessary, but it seems safest this way.
    class { 'nfs::rpcidmapd':
        stage   => 'early',
        domain  => "${domain}",
    }
}

#
# Global Defaults for Resource Types
#

Exec {
    # Ignore output of any exec, unless there was a failure.
    logoutput   => 'on_failure',
    # Match Fedora's default PATH.
    path        => "/usr/bin:/usr/sbin/:/bin:/sbin",
}

File {
    # For any overwritten files, keep backups in the main filebucket (defined
    # above).
    backup  => "main",
}

# Puppet will not automatically exec newaliases when mail aliases are
# configured as it rightly makes no assumptions about the mail system
# configuration.  However, this is suitable for our scope.
Mailalias {
    notify  => Exec['newaliases'],
}
exec { "newaliases":
    refreshonly => true,
}

Package {
    # Depend on yum being used and configured first.
    provider    => 'yum',
}

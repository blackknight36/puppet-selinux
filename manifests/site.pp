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
    # It might also be necessary for the NFS ID mapper to be functional early.
    class { 'nfs::client':
        stage   => 'early',
        # While we don't use Kerberos for NFS authentication, it helps to have
        # it enabled for older Fedora releases.  See commit 948e0c47.  It
        # certainly is not necessary starting with Fedora 21 though since the
        # service won't even start if the keytab file isn't present.
        use_gss => true,
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

Package {
    # Depend on yum being used and configured first.
    provider    => 'yum',
}

# manifests/site.pp

# The filebucket option allows for file backups to the server
filebucket { 'main':
    server  => 'puppet.dartcontainer.com',
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
# Global Defaults for Resource Types
#

Exec {
    # Ignore output of any exec, unless there was a failure.
    logoutput   => 'on_failure',
    # Match Fedora's default PATH.
    path        => '/usr/bin:/usr/sbin/:/bin:/sbin',
}

File {
    # For any overwritten files, keep backups in the main filebucket (defined
    # above).
    backup  => 'main',
}

if versioncmp($::puppetversion,'3.6.1') >= 0 {
    $allow_virtual_packages = hiera('allow_virtual_packages',false)
        Package {
            # Depend on yum being used and configured first.
            provider    => 'yum',
            # Preserve current behavior and disable the annoying warning message
            allow_virtual => $allow_virtual_packages,
        }
}
else {
    Package {
        provider => 'yum',
    }
}

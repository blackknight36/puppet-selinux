# modules/yum/manifests/remove.pp
#
# Synopsis:
#       Remove a package directly with yum.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            package name
#
# Requires:
#       NONE
#
# Notes:
#       Generally it would be preferred to use puppet's native Package
#       resource to ensure a package absence, but there are situations where
#       that doesn't work well, such as when:
#               1. the package may have a dependency chain that would be
#               difficult to express using native Package resources.
#               2. during the configuration of YUM itself where this would set
#               up a dependency loop between Packages and that class.
#
# Example Usage:
#
#       include yum
#
#       yum::remove { 'foo': }


define yum::remove {

    exec { "yum -y remove ${name}":
        onlyif  => "rpm -q ${name}",
    }

}


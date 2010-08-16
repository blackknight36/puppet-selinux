# /etc/puppet/manifests/site.pp

import "nodes"

# The filebucket option allows for file backups to the server
filebucket { "main":
    server	=> "puppet.dartcontainer.com",
}

# Bring in yum now so that it can be made a default requirement of all
# packages.
include yum

# Set global defaults - including backing up all files to the main filebucket
# and adds a global path.
Exec {
    path	=> "/usr/bin:/usr/sbin/:/bin:/sbin",
}

File {
    backup	=> "main",
}

# Puppet will not automatically exec newaliases when mail aliases are
# configured as it rightly makes no assumptions about the mail system
# configuration.  However, this is suitable for our scope.
Mailalias {
    notify      => Exec['newaliases'],
}
exec { "newaliases":
    refreshonly => true,
}

Package {
    require	=> Class["yum"]
}

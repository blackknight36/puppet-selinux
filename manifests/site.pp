# /etc/puppet/manifests/site.pp

# import "modules"	-- no longer needed with newer versions of puppet
import "nodes"

# The filebucket option allows for file backups to the server
filebucket { "main":
    server	=> "puppet.dartcontainer.com",
}

# Bring in yum now so that it can be made a default requirement of all packages.
include yum

# Set global defaults - including backing up all files to the main filebucket and adds a global path
Exec {
    path	=> "/usr/bin:/usr/sbin/:/bin:/sbin",
}

File {
    backup	=> "main",
}

Package {
    require	=> Class["yum"]
}

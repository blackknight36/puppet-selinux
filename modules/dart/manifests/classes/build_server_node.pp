# /etc/puppet/modules/dart/manifests/classes/build_server_node.pp

class dart::build_server_node inherits dart::server_node {
    include packages::developer
    include packages::net_tools
    include unwanted-services

    # TODO: create /j/{git,rpmbuild}
    # Right now it easiest to just rsync /j from another build server.

    # Ensure that package meta-data reports canonical host name rather than
    # "localhost".
    file { "/etc/hosts":
	content	=> template("dart/hosts"),
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        seluser => "system_u",
        selrole => "object_r",
        seltype => "net_conf_t",
    }

}

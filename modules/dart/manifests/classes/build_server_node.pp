# /etc/puppet/modules/dart/manifests/classes/build_server_node.pp

class dart::build_server_node inherits dart::server_node {
    include packages::developer
    include packages::net_tools
    include unwanted-services

    # TODO: create /j/{git,rpmbuild}
    # Right now it easiest to just rsync /j from another build server.

    file { "/etc/rpm-build-tools/git.conf":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["rpm-build-tools"],
        source  => "puppet:///dart/rpm-build-tools/git.conf",
    }

    file { "/etc/rpm-build-tools/rpmbuild.conf":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["rpm-build-tools"],
        source  => "puppet:///dart/rpm-build-tools/rpmbuild.conf",
    }

    file { "/etc/rpm-build-tools/yum.conf":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["rpm-build-tools"],
        source  => "puppet:///dart/rpm-build-tools/yum.conf",
    }

}

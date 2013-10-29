# modules/dart/manifests/abstract/build_server_node.pp

class dart::abstract::build_server_node inherits dart::abstract::guarded_server_node {

    class { 'dart::subsys::autofs::common':
        legacy  => false,
    }

    include packages::developer
    include packages::net_tools

    class { 'puppet::client':
    }

    include unwanted-services

    file { '/j':
        ensure  => directory,
        group   => 'd13677',
        mode    => '0755',
        owner   => 'd13677',
        require => Class['authconfig'],
        seluser => 'unconfined_u',
        selrole => 'object_r',
        seltype => 'default_t',
    }

    file { '/j/rpmbuild':
        ensure  => directory,
        group   => 'd13677',
        mode    => '0755',
        owner   => 'd13677',
        require => File['/j'],
        seluser => 'unconfined_u',
        selrole => 'object_r',
        seltype => 'default_t',
    }

    exec { 'rpmdev-setuptree -d':
        creates     => '/j/rpmbuild/BUILD',
        environment => 'HOME=/home/00/d13677',
        user        => 'd13677',
        logoutput   => true,
    }

}

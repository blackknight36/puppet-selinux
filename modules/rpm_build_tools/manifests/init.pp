# modules/rpm_build_tools/manifests/init.pp

class rpm_build_tools {

    package { "rpm-build-tools":
        ensure  => latest,
    }

    file { "/etc/rpm-build-tools/git.conf":
        group   => "root",
        mode    => "0644",
        owner   => "root",
        require => Package["rpm-build-tools"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "etc_t",
        source  => "puppet:///modules/rpm_build_tools/git.conf",
    }

    file { "/etc/rpm-build-tools/rpmbuild.conf":
        group   => "root",
        mode    => "0644",
        owner   => "root",
        require => Package["rpm-build-tools"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "etc_t",
        source  => "puppet:///modules/rpm_build_tools/rpmbuild.conf",
    }

    file { "/etc/rpm-build-tools/yum.conf":
        group   => "root",
        mode    => "0644",
        owner   => "root",
        require => Package["rpm-build-tools"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "etc_t",
        source  => "puppet:///modules/rpm_build_tools/yum.conf",
    }

}

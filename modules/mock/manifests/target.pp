# modules/mock/manifests/target.pp
#
# Synopsis:
#       Configures a host with a mock build-target configuration.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
#       family                  e.g., 'fedora' or 'epel'
#
#       release                 e.g., '19'
#
#       arch                    e.g., 'x86_64', 'i386', 'arm', 'ppc64'
#
# Notes:
#
#       1. Default is 'present'.


define mock::target ($family, $release, $arch, $ensure='present') {

    include 'mock::common'
    include 'mock::params'

    File {
        owner   => 'root',
        group   => 'mock',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        require => Class['mock::common'],
    }

    file { "/etc/mock/${family}-${release}-${arch}.cfg":
        content => template("mock/${family}.erb"),
    }

}

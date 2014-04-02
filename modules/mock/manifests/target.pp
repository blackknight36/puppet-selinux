# modules/mock/manifests/target.pp
#
# == Define: mock::target
#
# Installs a build-target configuration file for mock.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the target instance.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*family*]
#   The build target's distribution family.  E.g., 'fedora' or 'epel'.
#
# [*release*]
#   The build target's distribution release.  E.g., '20'.
#
# [*arch*]
#   The build target's distribution platform architecture.  E.g., 'x86_64',
#   'i386', 'arm', 'ppc64', etc.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define mock::target ($family, $release, $arch, $ensure='present') {

    include 'mock::common'
    include 'mock::params'

    File {
        owner       => 'root',
        group       => 'mock',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$mock::params::packages],
    }

    file { "/etc/mock/${family}-${release}-${arch}.cfg":
        content => template("mock/${family}.erb"),
    }

}

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
# [*target_arch*]
#   The machine hardware architecture that mock is to target when building
#   rpms.  This mostly affects code compilation.
#
# [*base_arch*]
#   The base architecture for the build target.  This affects mock's
#   configuration for yum repositories so that it can populate the build root
#   with the minimum package set plus all BuildRequires.
#
# [*legal_host_arches*]
#   To legally use this build target, the build host must be of a platform
#   architecture contained in this list.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define mock::target (
        $family,
        $release,
        $target_arch,
        $base_arch,
        $legal_host_arches,
        $ensure='present',
    ) {

    include 'mock::common'
    include 'mock::params'

    file { "/etc/mock/${family}-${release}-${base_arch}.cfg":
        ensure    => $ensure,
        owner     => 'root',
        group     => 'mock',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$mock::params::packages],
        content   => template("mock/${family}.erb"),
    }

}

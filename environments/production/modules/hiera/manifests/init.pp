# modules/hiera/manifests/init.pp
#
# == Class: hiera
#
# Manages Hiera on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*content*]
#   Literal content for the hiera configuration file.  If neither "content"
#   nor "source" is given, the content of the file will be left unmanaged.
#
# [*source*]
#   URI of the hiera configuration file content.  If neither "content" nor
#   "source" is given, the content of the file will be left unmanaged.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


class hiera (
        $content=undef,
        $source=undef,
    ) inherits ::hiera::params {

    package { $::hiera::params::packages:
        ensure => installed,
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::hiera::params::packages],
    }

    file { '/etc/puppet/hiera.yaml':
        content => $content,
        source  => $source,
        group   => 'puppet',
        seltype   => 'puppet_etc_t',
    }

}

# modules/mdct_puppeteer/manifests/admin.pp
#
# == Class: mdct_puppeteer::admin
#
# Configures mdct-puppeteer-admin on a host.
#
# === Parameters
#
# [*ensure*]
#   What state should the package be in?  One of: "present" (the default, also
#   called "installed"), "absent", "latest" or some specific version.
#
# [*content*]
#   Literal content for the mdct-puppeteer-admin.conf file.  One and only one
#   of "content" or "source" must be given.
#
# [*source*]
#   URI of the mdct-puppeteer-admin.conf file content.  One and only one of
#   "content" or "source" must be given.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class mdct_puppeteer::admin (
        $ensure='present',
        $content=undef,
        $source=undef,
    ) {

    include 'mdct_puppeteer::admin::params'

    package { $mdct_puppeteer::admin::params::packages:
        ensure  => $ensure,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$mdct_puppeteer::admin::params::packages],
    }

    file { '/etc/mdct-puppeteer-admin/mdct-puppeteer-admin.conf':
        content     => $content,
        source      => $source,
    }

}

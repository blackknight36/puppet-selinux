# modules/mdct_puppeteer/manifests/init.pp
#
# == Class: mdct_puppeteer
#
# Configures mdct-puppeteer on a host.
#
# == Notes
#
# While the mdct-puppeteer package is built into the MDCT AOS on Flash and
# very much an integral part of it, this class exists so that nodes can be
# forced to update themselves.  The first run after each boot will always use
# the integral version, but this class will ensure that each subsequent
# execution will be for the specified version.
#
# === Parameters
#
# [*ensure*]
#   What state should the package be in?  One of: "present" (the default, also
#   called "installed"), "absent", "latest" or some specific version.
#
# [*content*]
#   Literal content for the mdct-puppeteer.conf file.  One and only one of
#   "content" or "source" must be given.
#
# [*source*]
#   URI of the mdct-puppeteer.conf file content.  One and only one of
#   "content" or "source" must be given.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class mdct_puppeteer (
        $ensure='present',
        $content=undef,
        $source=undef,
    ) {

    include 'mdct_puppeteer::params'

    package { $mdct_puppeteer::params::packages:
        ensure  => $ensure,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$mdct_puppeteer::params::packages],
    }

    file { '/etc/mdct-puppeteer.conf':
        content     => $content,
        source      => $source,
    }

}

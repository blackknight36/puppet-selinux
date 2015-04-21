# modules/koji/manifests/web.pp
#
# == Class: koji::web
#
# Manages the Koji Web component on a host.
#
# === Assumptions
#
# This class presently assumes that the Koji-Web component is deployed on the
# same host as the Koji-Hub component.  Additional work in the Puppet
# resources would be required to allow these to be split apart since both
# components require Apache httpd and mod_ssl support.
#
# === Parameters
#
# ==== Required
#
# [*secret*]
#   Undocumented by the Koji project, but required.  FIXME
#
# ==== Optional
#
# [*theme*]
#   Name of the web theme that Koji is to use.  Content under
#   /usr/share/koji-web/static/themes/$theme will be used instead of the
#   normal files under /usr/share/koji-web/static/.  Any absent files will
#   fall back to the normal files.
#
# [*theme_source*]
#   This should point to a gzipped tarball providing content for the named
#   "theme".  The default is to not install an alternate theme.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::web (
        $secret,
        $theme='default',
        $theme_source=undef,
    ) inherits ::koji::params {

    include '::apache::params'

    package { $::koji::params::web_packages:
        ensure => installed,
    }

    # Duplicates that in koji::hub.  See assumptions note above.
    #   class { '::apache':
    #       network_connect_db => true,
    #       anon_write         => true,
    #   }

    include '::apache::mod_ssl'

    ::apache::site_config {
        # Duplicates that in koji::hub.  See assumptions note above.
        #   'ssl':
        #       source    => 'puppet:///modules/koji/httpd/ssl.conf',
        #       subscribe => Class['apache::mod_ssl'];
        'kojiweb':
            source      => 'puppet:///modules/koji/web/kojiweb.conf',
            subscribe   => Package[$::koji::params::web_packages];
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::apache::params::services],
        notify    => Service[$::apache::params::services],
        subscribe => Package[$::koji::params::web_packages],
    }

    file { '/etc/kojiweb/web.conf':
        content => template('koji/web/web.conf'),
    }

    if $theme_source {
        $themes_dir = '/usr/share/koji-web/static/themes'
        $theme_path = "${themes_dir}/${theme}"
        $theme_tgz = "${theme_path}.tgz"
        file { $theme_tgz:
            source => $theme_source,
        } ->
        exec { "tar xzf ${theme_tgz}":
            cwd     => $themes_dir,
            creates => $theme_path,
        }
    }

}

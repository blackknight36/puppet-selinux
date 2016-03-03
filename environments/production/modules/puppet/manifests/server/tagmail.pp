# modules/puppet/manifests/server/tagmail.pp
#
# == Class: puppet::server::tagmail
#
# Configures the puppet-tagmail package on a host.
#
# === Parameters
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>


class puppet::server::tagmail() {

    if versioncmp($::puppetversion, '3.7') > 0 {
        exec{'install-tagmail':
            creates => "/etc/puppet/environments/${::environment}/forge_modules/tagmail",
            command => "puppet module install --environment ${::environment} puppetlabs-tagmail",
        }
    }

    file { '/etc/puppet/tagmail.conf':
        owner   => 'root',
        group   => 'puppet',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'puppet_etc_t',
        source  => 'puppet:///private-host/puppet/tagmail.conf',
    }

    # provide patched version of tagmail to silence empty reports
    if versioncmp($::puppetversion, '4.0') < 0 {
        file{'/usr/share/ruby/vendor_ruby/puppet/reports/tagmail.rb':
            source => 'puppet:///modules/puppet/tagmail.rb',
        }
    }
}

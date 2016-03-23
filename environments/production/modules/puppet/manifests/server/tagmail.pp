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


class puppet::server::tagmail() inherits puppet::params {


    if $::operatingsystem == 'CentOS' {
        $forge_module_path = "${puppet::params::puppet_conf_dir}/code/environments/${::environment}/forge_modules"
        $command = "/opt/puppetlabs/bin/puppet module install --environment ${::environment} --modulepath $forge_module_path puppetlabs-tagmail"
        $creates = "${forge_module_path}/tagmail"
    }
    else {
        $command = "/usr/bin/puppet module install --environment ${::environment} puppetlabs-tagmail"
        $creates = "${puppet::params::puppet_conf_dir}/environments/${::environment}/forge_modules/tagmail"
    }

    if versioncmp($::puppetversion, '4.0') >= 0 {
        exec{'install-tagmail':
            command => $command,
            creates => $creates,
        }
    }

    $tagmail_template = $::operatingsystemrelease ? {
        '21' => 'puppet/tagmail/tagmail.conf.f21.erb',
        '22' => 'puppet/tagmail/tagmail.conf.f22.erb',
        '23' => 'puppet/tagmail/tagmail.conf.f22.erb',
        '7.2.1511' => 'puppet/tagmail/tagmail.conf.f22.erb',
    }

    $puppet_admins = hiera('puppet_admins', 'root')
    $tcutil_admins = hiera('tcutil_admins', 'root')

    file { "${puppet::params::puppet_conf_dir}/tagmail.conf":
        owner   => 'root',
        group   => 'puppet',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'puppet_etc_t',
        content => template($tagmail_template),
    }

    # provide patched version of tagmail to silence empty reports
    if versioncmp($::puppetversion, '4.0') < 0 {
        file{'/usr/share/ruby/vendor_ruby/puppet/reports/tagmail.rb':
            source => 'puppet:///modules/puppet/tagmail.rb',
        }
    }
}

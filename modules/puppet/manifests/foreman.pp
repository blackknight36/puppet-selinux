# modules/puppet/manifests/foreman.pp
#
# == Class: puppet::foreman
#
# Configures a Puppet Master host to communicate with a Foreman server.
#
# === Parameters
#
# [*foreman_url*]
#   URL of your Foreman installation.
#
# [*ssl_ca*]
#   Certificate Authority for puppet master, foreman, etc. certificates.
#
# [*ssl_cert*]
#   The puppet master's certificate.
#
# [*ssl_key*]The puppet master's private key.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class puppet::foreman (
        $foreman_url, $ssl_ca=undef, $ssl_cert=undef, $ssl_key=undef,
        $puppet_home='/var/lib/puppet', $puppet_user='puppet', $facts=true,
    ) {

    include 'puppet::params'

#   package { $puppet::params::packages:
#       ensure  => installed,
#       notify  => Service[$puppet::params::service_name],
#   }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'usr_t',
#       before      => Service[$puppet::params::service_name],
#       notify      => Service[$puppet::params::service_name],
#       subscribe   => Package[$puppet::params::packages],
    }

    # for report submission into foreman
    file { '/usr/share/ruby/vendor_ruby/puppet/reports/foreman.rb':
        content => template('puppet/foreman-report_v2.rb.erb'),
    }

    # for fact submission into foreman and to use foreman as an ENC
    file { '/etc/puppet/node.rb':
        group   => 'puppet',
        mode    => '0750',
        content => template('puppet/external_node_v2.rb.erb'),
    }

#   iptables::tcp_port {
#       'SERVICE_NAME': port => 'SERVICE_PORT_1';
#       'SERVICE_NAME': port => 'SERVICE_PORT_2';
#   }

#   service { $puppet::params::service_name:
#       enable      => true,
#       ensure      => running,
#       hasrestart  => true,
#       hasstatus   => true,
#   }

}

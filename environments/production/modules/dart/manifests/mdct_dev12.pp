# modules/dart/manifests/mdct_dev12.pp
#
# == Class: dart::mdct_dev12
#
# Manages John Florian's workstation.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12 inherits dart::abstract::workstation_node {

    # Apache httpd is needed for at least serving man2html, but may be used
    # for development and/or debugging setups of dhcpd-driven-master or
    # firewall-driven-master, hence the network_connect setting.
    class { '::apache':
        network_connect => true,
    }

    class { '::jaf_bacula::client':
        dir_name   => $::dart::params::bacula_dir_name,
        dir_passwd => 'RB9c3KBgpRyXzbGC6wXCEA5ao2SAtgAyt24tD8pni17h',
        mon_name   => $::dart::params::bacula_mon_name,
        mon_passwd => 'NBkHwmNJGplxIlmMaQukmf568KCSuY1eKDGINZnLxyTw',
    }

    include '::dart::abstract::pycharm::professional'
    include '::dart::abstract::rubymine'
    include '::dart::mdct_dev12::aos_nightlies'
    include '::dart::mdct_dev12::filesystem'
    include '::dart::mdct_dev12::libvirt'
    include '::dart::mdct_dev12::network'
    include '::dart::mdct_dev12::packaging'
    include '::dart::mdct_dev12::profile'
    include '::dart::subsys::mock'

    printer { 'dell':
        uri         => 'socket://10.209.44.64:9100',
        description => 'Dell 3100cn',
        location    => 'cubicle of Chris Kennedy',
        model       => 'foomatic:Dell-3100cn-pxlcolor.ppd',
    } ->

    default_printer { 'dell':
        ensure => present,
    }

    class { '::selinux':
        mode => 'enforcing',
    }

}

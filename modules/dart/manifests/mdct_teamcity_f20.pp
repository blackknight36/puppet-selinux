# modules/dart/manifests/mdct_teamcity_f20.pp
#
# == Class: dart::mdct_teamcity_f20
#
# Configures a host as our TeamCity Server with a Build Agent
#
# === Parameters
#
# NONE
#
# === Contact
#
#   John Florian <john.florian@dart.biz>
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_teamcity_f20 inherits dart::abstract::teamcity_server_node {

    sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

    class { 'jaf_bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => 'RFdZ9Dm9bxuIEIp1Q7Gu0sEoHX9AUHecFbwE6weT1IAz',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => 'hRGbzxczzByoo9chMe7y6Qlxeo0dmfedAKJCP9Y2M4o6',
    }

    class { '::network':
        service => 'legacy',
    }

    network::interface { 'eth0':
            template    => 'static',
            ip_address  => '10.201.64.16',
            netmask     => '255.255.252.0',
            gateway     => '10.201.67.254',
            stp         => 'no',
    }

}

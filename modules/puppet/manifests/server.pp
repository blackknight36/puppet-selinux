# modules/puppet/manifests/server.pp

class puppet::server {

    include cron::daemon
    include lokkit

    package { 'puppet-server':
	ensure	=> installed,
    }

    package { 'puppet-tools':
	ensure	=> installed,
    }

    file { '/etc/puppet/fileserver.conf':
        group	=> 'root',
        mode    => '0644',
        owner   => 'root',
        require => Package['puppet-server'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'puppet_etc_t',
        # This one can be a bit of a 'chicken vs. egg' problem.  There's
        # little point in providing a source here since the target is already
        # within git.
        #       source  => 'puppet:///modules/puppet/fileserver.conf',
    }

    file { '/etc/sysconfig/puppetmaster':
        group	=> 'root',
        mode    => '0640',
        owner   => 'root',
        require => Package['puppet-server'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        source  => 'puppet:///modules/puppet/puppetmaster',
    }

    # All other puppet resources are managed via GIT 'in place'.

    lokkit::tcp_port { 'puppetmaster':
        port    => '8140',
    }

    service { 'puppetmaster':
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec['open-puppetmaster-tcp-port'],
            Package['puppet-server'],
        ],
        subscribe	=> [
            File['/etc/puppet/fileserver.conf'],
            File['/etc/sysconfig/puppetmaster'],
        ],
    }

}

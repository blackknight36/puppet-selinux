# modules/puppet/manifests/server.pp

class puppet::server {

    include cron::daemon
    include puppet::client
    include puppet::params


    package { $puppet::params::server_packages:
        ensure  => installed,
        notify  => Service[$puppet::params::server_service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'puppet_etc_t',
        before      => Service[$puppet::params::server_service_name],
        notify      => Service[$puppet::params::server_service_name],
        subscribe	=> Package[$puppet::params::server_packages],
    }

    file { '/etc/puppet/fileserver.conf':
        # This one can be a bit of a 'chicken vs. egg' problem.  There's
        # little point in providing a source here since the target is already
        # within git.  The rest of the (default) file parameters still apply,
        # however.
        #       source  => 'puppet:///modules/puppet/fileserver.conf',
        mode    => '0644',
    }

    file { '/etc/sysconfig/puppetmaster':
        seltype => 'etc_t',
        source  => 'puppet:///modules/puppet/puppetmaster',
    }

    # All other puppet resources, except puppet.conf (see client.pp), are
    # managed via GIT 'in place'.

    lokkit::tcp_port { 'puppetmaster':
        port    => '8140',
    }

    service { $puppet::params::server_service_name:
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        subscribe	=> [ File['/etc/puppet/puppet.conf'], ],
    }

}

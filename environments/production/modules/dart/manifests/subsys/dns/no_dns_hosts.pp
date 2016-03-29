# modules/dart/manifests/subsys/dns/no_dns_hosts.pp
# vim: foldmethod=marker
#
# Synopsis:
#       Host resolution details for hosts not in Dart's DNS records.

class dart::subsys::dns::no_dns_hosts {

    # Abandoned hosts; names/addresses free for recycling {{{
    #
    # Please be nice and group with a purge tag dated ~30 days in the future
    # and ensure absent until then.  That gives plenty of opportunity for all
    # nodes to drop these entries.  After the purge date, the records can be
    # deleted from here permanently.


    #}}}

    # Active hosts {{{

    # Koji/Sigul {{{

    host { 'mdct-koji-b1-f21.dartcontainer.com':
        ip           => '10.201.64.34',
        host_aliases => [ 'mdct-koji-b1.dartcontainer.com',
                          'mdct-koji-b1-f21', 'mdct-koji-b1' ],
    }

    host { 'mdct-koji-b2-f21.dartcontainer.com':
        ip           => '10.201.64.35',
        host_aliases => [ 'mdct-koji-b2.dartcontainer.com',
                          'mdct-koji-b2-f21', 'mdct-koji-b2' ],
    }

    host { 'mdct-koji-b3-f21.dartcontainer.com':
        ip           => '10.201.64.36',
        host_aliases => [ 'mdct-koji-b3.dartcontainer.com',
                          'mdct-koji-b3-f21', 'mdct-koji-b3' ],
    }

    host { 'mdct-koji-b4-f21.dartcontainer.com':
        ip           => '10.201.64.37',
        host_aliases => [ 'mdct-koji-b4.dartcontainer.com',
                          'mdct-koji-b4-f21', 'mdct-koji-b4' ],
    }

    host { 'mdct-koji-b5-f21.dartcontainer.com':
        ip           => '10.201.64.38',
        host_aliases => [ 'mdct-koji-b5.dartcontainer.com',
                          'mdct-koji-b5-f21', 'mdct-koji-b5' ],
    }

    host { 'mdct-koji-f21.dartcontainer.com':
        ip           => '10.201.64.39',
        host_aliases => [ 'mdct-koji.dartcontainer.com',
                          'mdct-koji-f21', 'mdct-koji', 'koji' ],
    }

    host { 'mdct-sigul-bridge-f21.dartcontainer.com':
        ip           => '10.201.64.42',
        host_aliases => [ 'mdct-sigul-bridge.dartcontainer.com',
                          'mdct-sigul-bridge-f21', 'mdct-sigul-bridge',
                          'sigul-bridge' ],
    }

    host { 'mdct-sigul-f21.dartcontainer.com':
        ip           => '10.201.64.43',
        host_aliases => [ 'mdct-sigul.dartcontainer.com',
                          'mdct-sigul-f21', 'mdct-sigul', 'sigul' ],
    }

    #}}}

    # oVirt {{{

    host { 'mdct-ovirt-engine.dartcontainer.com':
        ip           => '10.201.64.47',
        host_aliases => [ 'mdct-ovirt-engine' ],
    }

    host { 'mdct-ovirt-node-production1.dartcontainer.com':
        ip           => '10.1.192.171',
        host_aliases => [ 'mdct-ovirt-node-production1' ],
    }

    host { 'mdct-ovirt-node-production2.dartcontainer.com':
        ip           => '10.1.192.172',
        host_aliases => [ 'mdct-ovirt-node-production2' ],
    }

    #}}}

    #Purge after 2015-11-16 Teamcity{{{

    host { 'mdct-teamcity-agent1.dartcontainer.com':
        ensure       => absent,
        ip           => '10.1.192.125',
        host_aliases => [ 'mdct-teamcity-agent1' ],
    }

    host { 'mdct-teamcity-agent2.dartcontainer.com':
        ensure       => absent,
        ip           => '10.1.192.133',
        host_aliases => [ 'mdct-teamcity-agent2' ],
    }

    host { 'mdct-teamcity-agent3.dartcontainer.com':
        ensure       => absent,
        ip           => '10.1.192.134',
        host_aliases => [ 'mdct-teamcity-agent3' ],
    }

    #}}}

    #Purge after 2015-11-16 Workstations {{{

    host { 'mdct-dev16.dartcontainer.com':
        ensure       => absent,
        ip           => '10.209.44.16',
        host_aliases => [ 'mdct-dev16' ],
    }

    host { 'mdct-dev17.dartcontainer.com':
        ensure       => absent,
        ip           => '10.209.44.17',
        host_aliases => [ 'mdct-dev17' ],
    }

    host { 'mdct-dev19.dartcontainer.com':
        ensure       => absent,
        ip           => '10.209.44.19',
        host_aliases => [ 'mdct-dev19' ],
    }

    host { 'mdct-dev24.dartcontainer.com':
        ensure       => absent,
        ip           => '10.209.44.24',
        host_aliases => [ 'mdct-dev24' ],
    }

    #}}}

    host { 'mdct-pt-dbtest.dartcontainer.com':
        ip           => '10.1.192.144',
        host_aliases => [ 'mdct-pt-dbtest' ],
    }

    host { 'tc-util.dartcontainer.com':
        ip           => '10.1.250.61',
        host_aliases => [ 'tc-util' ],
    }

    host { 'mdct-tc-f20.dartcontainer.com':
        ip           => '10.201.64.3',
        host_aliases => [ 'mdct-tc-f20' ],
    }

    host { 'mdct-graphite.dartcontainer.com':
        ip           => '10.201.64.17',
        host_aliases => [ 'mdct-graphite' ],
    }

    if $::operatingsystem == 'Fedora' and $::operatingsystemrelease >= '20' {

        host { 'puppet.dartcontainer.com':
            ip           => '10.201.64.50',
            host_aliases => [ 'puppet' ],
        }
    }

    #}}}

}

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

    # Purge after 2015-05-22 {{{
    host { 'mdct-f14-builder.dartcontainer.com':
        ensure       => absent,
        ip           => '10.1.192.137',
        host_aliases => [ 'mdct-f14-builder', 'f14b' ],
    }

    host { 'mdct-f15-builder.dartcontainer.com':
        ensure       => absent,
        ip           => '10.1.192.138',
        host_aliases => [ 'mdct-f15-builder', 'f15b' ],
    }

    host { 'mdct-f16-builder.dartcontainer.com':
        ensure       => absent,
        ip           => '10.1.192.139',
        host_aliases => [ 'mdct-f16-builder', 'f16b' ],
    }
    #}}}

    #}}}

    # Active hosts {{{

    # Koji/Sigul {{{

    host { 'mdct-koji-b1-f21.dartcontainer.com':
        ip           => '10.1.192.135',
        host_aliases => [ 'mdct-koji-b1.dartcontainer.com',
                          'mdct-koji-b1-f21', 'mdct-koji-b1' ],
    }

    host { 'mdct-koji-b2-f21.dartcontainer.com':
        ip           => '10.1.192.136',
        host_aliases => [ 'mdct-koji-b2.dartcontainer.com',
                          'mdct-koji-b2-f21', 'mdct-koji-b2' ],
    }

    host { 'mdct-koji-b3-f21.dartcontainer.com':
        ip           => '10.1.192.137',
        host_aliases => [ 'mdct-koji-b3.dartcontainer.com',
                          'mdct-koji-b3-f21', 'mdct-koji-b3' ],
    }

    host { 'mdct-koji-b4-f21.dartcontainer.com':
        ip           => '10.1.192.143',
        host_aliases => [ 'mdct-koji-b4.dartcontainer.com',
                          'mdct-koji-b4-f21', 'mdct-koji-b4' ],
    }

    host { 'mdct-koji-b5-f21.dartcontainer.com':
        ip           => '10.1.192.145',
        host_aliases => [ 'mdct-koji-b5.dartcontainer.com',
                          'mdct-koji-b5-f21', 'mdct-koji-b5' ],
    }

    host { 'mdct-koji-f21.dartcontainer.com':
        ip           => '10.1.192.124',
        host_aliases => [ 'mdct-koji.dartcontainer.com',
                          'mdct-koji-f21', 'mdct-koji', 'koji' ],
    }

    host { 'mdct-sigul-bridge-f21.dartcontainer.com':
        ip           => '10.1.192.138',
        host_aliases => [ 'mdct-sigul-bridge.dartcontainer.com',
                          'mdct-sigul-bridge-f21', 'mdct-sigul-bridge',
                          'sigul-bridge' ],
    }

    host { 'mdct-sigul-f21.dartcontainer.com':
        ip           => '10.1.192.139',
        host_aliases => [ 'mdct-sigul.dartcontainer.com',
                          'mdct-sigul-f21', 'mdct-sigul', 'sigul' ],
    }

    #}}}

    # oVirt {{{

    host { 'mdct-ovirt-engine.dartcontainer.com':
        ip           => '10.1.192.170',
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

    # TeamCity {{{

    host { 'mdct-teamcity-agent1.dartcontainer.com':
        ip           => '10.1.192.125',
        host_aliases => [ 'mdct-teamcity-agent1' ],
    }

    host { 'mdct-teamcity-agent2.dartcontainer.com':
        ip           => '10.1.192.133',
        host_aliases => [ 'mdct-teamcity-agent2' ],
    }

    host { 'mdct-teamcity-agent3.dartcontainer.com':
        ip           => '10.1.192.134',
        host_aliases => [ 'mdct-teamcity-agent3' ],
    }

    #}}}

    # Workstations {{{

    host { 'mdct-dev15.dartcontainer.com':
        ip           => '10.1.250.50',
        host_aliases => [ 'mdct-dev15' ],
    }

    host { 'mdct-dev16.dartcontainer.com':
        ip           => '10.1.250.46',
        host_aliases => [ 'mdct-dev16' ],
    }

    host { 'mdct-dev17.dartcontainer.com':
        ip           => '10.1.250.36',
        host_aliases => [ 'mdct-dev17' ],
    }

    host { 'mdct-dev18.dartcontainer.com':
        ip           => '10.1.250.182',
        host_aliases => [ 'mdct-dev18' ],
    }

    host { 'mdct-dev19.dartcontainer.com':
        ip           => '10.1.250.183',
        host_aliases => [ 'mdct-dev19' ],
    }

    host { 'mdct-dev24.dartcontainer.com':
        ip           => '10.1.250.186',
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

    #}}}

}

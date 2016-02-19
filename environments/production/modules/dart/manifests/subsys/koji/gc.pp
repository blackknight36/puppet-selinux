# modules/dart/manifests/subsys/koji/gc.pp
#
# == Class: dart::subsys::koji::gc
#
# Manages the Koji garbage collector.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::koji::gc inherits ::dart::subsys::koji::params {

    class { '::koji::gc':
        ca_cert        => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        client_cert    => "puppet:///modules/dart/koji/koji-gc-on-${::dart::subsys::koji::params::koji_gc_host}.pem",
        grace_period   => '2 weeks',
        hub            => $::dart::subsys::koji::params::hub,
        keys           => $::dart::subsys::koji::params::rpm_signing_keys,
        oldest_scratch => '30',
        smtp_host      => $::dart::params::smtp_server,
        top_dir        => $::dart::subsys::koji::params::topdir,
        web            => "http://${::dart::subsys::koji::params::web_host}/koji",
        web_ca_cert    => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
    }

    ::koji::gc::policy {
        # Don't count newborns for ordering tests.  Give them a chance for
        # adoption.
        'skip builds less than a day old':
            seq   => '100',
            rule  => 'age < 1 day :: skip',
            ;
        # Preserve test builds for a reasonably long time.  Multiple
        # developers may be involved and testing of _their_ build could take
        # some time.
        'keep tests builds less than a 4 weeks old':
            seq   => '110',
            rule  => 'tag *-testing && age < 4 weeks :: keep',
            ;
        # Untag everything else that has been obsoleted by a few subsequent
        # builds.
        'untag obsoleted builds':
            seq   => '120',
            rule  => 'order > 2:: untag',
            ;
    }

}

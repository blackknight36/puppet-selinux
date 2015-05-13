# modules/dart/manifests/subsys/koji/repoview.pp
#
# == Class: dart::subsys::koji::repoview
#
# Manages the repoview subsystem on a Dart host.
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


class dart::subsys::koji::repoview {

    include '::cron::daemon'

    File {
        owner => 'root',
        group => 'repomgr',
        mode  => '0755',
    }

    file {
        '/usr/libexec/dart-repoview':
            source => 'puppet:///modules/dart/koji/dart-repoview',
            ;

        '/usr/libexec/mdct-repoview':
            source => 'puppet:///modules/dart/koji/mdct-repoview',
            ;

        '/var/log/dart-repoview':
            ensure => 'directory',
            mode   => '0775',
            ;
    } ->

    # We don't need a cron job for mdct-repoview any more since that content
    # is all static "as is" now.

    ::cron::job { 'dart-repoview':
        command => 'nice ionice -c 3 /usr/libexec/dart-repoview 21 20',
        minute  => '*/15',
        hour    => '*',
        user    => 'repomgr',
    }

}

# modules/cron/manifests/job.pp
#
# == Define: cron::job
#
# Installs a single job configuration for cron.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the job instance.  Results in a cron job file
#   named "/etc/cron.d/$name".
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*command*]
#   Command to be executed by cron.
#
# [*user*]
#   Identity that cron should should assume when running the command.
#   Defaults to "root".
#
# [*minute*]
#   Valid: 0-59, ranges via hyphen, lists via comma or steps via slashes or no
#   restriction via star.  Defaults to "*".
#
# [*hour*]
#   Valid: 0-23, ranges via hyphen, lists via comma or steps via slashes or no
#   restriction via star.  Defaults to "*".
#
# [*dom*]
#   Valid: 1-31, ranges via hyphen, lists via comma or steps via slashes or no
#   restriction via star.  Defaults to "*".
#
# [*month*]
#   Valid: 1-12, names (e.g., "Feb"), ranges via hyphen, lists via comma or
#   steps via slashes or no restriction via star.  Defaults to "*".
#
# [*dow*]
#   Valid: 0-7, names (e.g., "Mon"), ranges via hyphen, lists via comma or
#   steps via slashes or no restriction via star.  Defaults to "*".  Note that
#   either 0 or 7 may be used to indicate Sunday.
#
# [*mailto*]
#   Any stdout/stderr will be sent here.  May be a user name for localhost
#   mail or a fully qualified email address.  If set to "" (an empty string),
#   no mail will be sent.  Defaults to "root".
#
# [*path*]
#   Executable search path to be used in environment while running command.
#   Defaults to "/sbin:/bin:/usr/sbin:/usr/bin".
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define cron::job ($command,
                  $ensure='present',
                  $minute='*',
                  $hour='*',
                  $dom='*',
                  $month='*',
                  $dow='*',
                  $mailto='root',
                  $path='/sbin:/bin:/usr/sbin:/usr/bin',
                  $user='root') {

    case $dom {
        '': {
            fail('Required $dom (day of month) variable is not defined')
        }
    }

    case $dow {
        '': {
            fail('Required $dow (day of week) variable is not defined')
        }
    }

    case $hour {
        '': {
            fail('Required $hour variable is not defined')
        }
    }

    case $minute {
        '': {
            fail('Required $minute variable is not defined')
        }
    }

    case $month {
        '': {
            fail('Required $month variable is not defined')
        }
    }

    case $path {
        '': {
            fail('Required $path variable is not defined')
        }
    }

    case $command {
        '': {
            fail('Required $command variable is not defined')
        }
    }

    case $user {
        '': {
            fail('Required $user variable is not defined')
        }
    }

    file { "/etc/cron.d/${name}":
        content => template('cron/job'),
        ensure  => $ensure,
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        selrole => 'object_r',
        seltype => 'system_cron_spool_t',
        seluser => 'system_u',
    }

}

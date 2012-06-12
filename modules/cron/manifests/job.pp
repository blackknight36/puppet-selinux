# modules/cron/manifests/job.pp
#
# Synopsis:
#       Installs a single cron job.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#       name                            used as /etc/cron.d/$name
#       command                         command to be executed
#       ensure          present         absent/present
#       user            root            user to run job under
#       minute          *               0-59
#       hour            *               0-23
#       dom             *               1-31; day of the month
#       month           *               1-12 or use names
#       dow             *               0-7 or use names; day of the week
#       mailto                          results of cron job are sent here
#       path            /sbin:/bin:/usr/sbin:/usr/bin
#
# Requires:
#       Class['cron::daemon']
#
# Example usage:
#
#       include cron::daemon
#
#       cron::job { 'example':
#           minute  => '*/3',
#           command => 'date >> /tmp/crontest',
#       }

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
            fail('Required $dom (day of month) variable is not defined.')
        }
    }

    case $dow {
        '': {
            fail('Required $dow (day of week) variable is not defined.')
        }
    }

    case $hour {
        '': {
            fail('Required $hour variable is not defined.')
        }
    }

    case $mailto {
        '': {
            fail('Required $mailto variable is not defined.')
        }
    }

    case $minute {
        '': {
            fail('Required $minute variable is not defined.')
        }
    }

    case $month {
        '': {
            fail('Required $month variable is not defined.')
        }
    }

    case $path {
        '': {
            fail('Required $path variable is not defined.')
        }
    }

    case $command {
        '': {
            fail('Required $command variable is not defined.')
        }
    }

    case $user {
        '': {
            fail('Required $user variable is not defined.')
        }
    }

    file { "/etc/cron.d/${name}":
        content => template('cron/job'),
        ensure  => $ensure,
        group	=> 'root',
        mode    => '0644',
        owner   => 'root',
        selrole => 'object_r',
        seltype => 'system_cron_spool_t',
        seluser => 'system_u',
    }

}

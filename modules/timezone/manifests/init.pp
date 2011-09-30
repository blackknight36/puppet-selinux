# /etc/puppet/modules/timezone/manifests/init.pp

class timezone {

    # plant_number fact is unavailable due to puppet bugs.  See git 8f8ed3b
    # for details.
    #   $tzname = $plant_number ? {
    #       '01'    => 'America/Detroit',
    #       '02'    => 'America/Detroit',
    #       '11'    => 'America/Chicago',
    #       default => 'America/Detroit',
    #   }

    $tzname = 'America/Detroit'

    file { '/etc/sysconfig/clock':
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        content => template('timezone/clock'),
    }

    file { '/etc/localtime':
        ensure  => "/usr/share/zoneinfo/${tzname}",
    }

}

# modules/timezone/manifests/init.pp

class timezone {

    $tzname = $plant_number ? {
        '01'    => 'America/Detroit',
        '02'    => 'America/Detroit',
        '04'    => 'America/Chicago',
        '11'    => 'America/Chicago',
        default => 'America/Detroit',
    }
    info("Selected timezone $tzname based on plant_number $plant_number.  This may change next run if puppet has not yet achieved convergence.")

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

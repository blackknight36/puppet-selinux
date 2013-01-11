# modules/timezone/manifests/init.pp

class timezone {

    $tzname = $plant_number ? {
        '01'    => 'America/Detroit',                   # Mason
        '02'    => 'America/Detroit',                   # Leola
        '03'    => 'America/Detroit',                   # Lithonia
        '04'    => 'America/Chicago',                   # Aurora
        '05'    => 'America/Los_Angeles',               # Corona
        '10'    => 'America/Chicago',                   # Waxahachie
        '11'    => 'America/Chicago',                   # Horse Cave
        '15'    => 'America/Chicago',                   # Quitman
        '19'    => 'America/Detroit',                   # Plant City
        '25'    => 'America/Los_Angeles',               # Tumwater
        '39'    => 'America/Detroit',                   # Randleman
        '52'    => 'America/Detroit',                   # Lancaster
        '55'    => 'America/Los_Angeles',               # Lodi
        '72'    => 'America/Tijuana',                   # Tijuana
        '73'    => 'America/Argentina/Buenos_Aires',    # Argentina
        '75'    => 'Europe/London',                     # England
        '76'    => 'Australia/Sydney',                  # Australia
        '77'    => 'America/Detroit',                   # Canada
        '78'    => 'America/Mexico City',               # Atlacomulco
        default => 'America/Detroit',
    }

    if $operatingsystem == 'Fedora' and $operatingsystemrelease < 18 {

        file { '/etc/sysconfig/clock':
            group   => 'root',
            mode    => '0644',
            owner   => 'root',
            content => template('timezone/clock'),
        }

        file { '/etc/localtime':
            ensure  => link,
            target  => "/usr/share/zoneinfo/${tzname}",
        }

    } else {

        # This accomplishes the same symlink as the File resource above, but
        # is the preferred method using systemd on F18 and later.
        exec { "timedatectl set-timezone $tzname":
            unless  => "timedatectl status | grep -q $tzname",
        }

    }

}

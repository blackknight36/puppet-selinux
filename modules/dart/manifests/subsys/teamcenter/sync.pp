# modules/dart/manifests/subsys/teamcenter/sync.pp
#
# == Class: dart::subsys::teamcenter::sync
#
# Configures a host for the teamcenter-sync application.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::teamcenter::sync  {

    $credentials_fn = '/etc/tc-credentials'
    $sync_source = 'mas-cad55'

    file { $credentials_fn:
        owner   => 'root',
        group   => 'root',
        mode    => '0400',
        content => 'domain=MASON_NTD
username=tcservices
password=T5A!ENsER
',
    }

    $tcadmins_gid = '54321'
    group { 'tcadmins':
        gid    => $tcadmins_gid,
        system => false,
    }

    # Users defined in Active Directory; this just for group membership since
    # the 'groupadd' provider for the group type (above) does not support
    # membership management.
    user { ['d74326', 'd850293']:
        groups  => 'tcadmins',
        require => Group['tcadmins'],
    }

    # Mount defaults are idealized for sync targets since they number more
    # than sync sources.  Some parameters may not even be necessary for
    # sources, but may exist here if harmless or if overrided.
    Dart::Subsys::Teamcenter::Mount {
        group   => $tcadmins_gid,
        options => "rw,uid=0,gid=${tcadmins_gid},file_mode=0660,noperm,credentials=${credentials_fn}",
        require => [
            File[$credentials_fn],
            Group['tcadmins'],
        ],
    }

    # Sync Source
    dart::subsys::teamcenter::mount { 'teamcenter_source':
        host       => $sync_source,
        share_name => 'volumes',
        group      => 'root',
        mode       => '0555',
        options    => "credentials=${credentials_fn}",
    }

    # Sync Targets
    dart::subsys::teamcenter::mount {
        'teamcenter_renumber_test':
            host        => 'mas-cad23',
            share_name  => 'volumes';

        'teamcenter_preproduction_beta':
            host        => 'mas-cad26',
            share_name  => 'volumes';
    }

    file { '/usr/local/bin/teamcenter-sync':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => template('dart/tc_util/teamcenter-sync'),
    }

}

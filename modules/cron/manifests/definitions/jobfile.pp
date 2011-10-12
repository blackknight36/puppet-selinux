# modules/cron/manifests/definitions/jobfile.pp
#
# Synopsis:
#       Installs a single cron job file.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#       name                            used as /etc/cron.d/$name
#       ensure          present         absent/present
#       source                          puppet URI for obtaining the job file
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

define cron::jobfile ($source, $ensure='present') {

    case $source {
        '': {
            fail('Required $source variable is not defined.')
        }
    }

    file { "/etc/cron.d/${name}":
        ensure  => $ensure,
        group	=> 'root',
        mode    => '0644',
        owner   => 'root',
        selrole => 'object_r',
        seltype => 'system_cron_spool_t',
        seluser => 'system_u',
        source  => $source,
    }

}

# modules/cron/manifests/jobfile.pp
#
# == Define: cron::jobfile
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
# [*content*]
#   Literal content for the job file file.  One and only one of "content"
#   or "source" must be given.
#
# [*source*]
#   URI of the job file file content.  One and only one of "content" or
#   "source" must be given.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


define cron::jobfile (
        $ensure='present',
        $content=undef,
        $source=undef,
    ) {

    include 'cron::params'

    file { "/etc/cron.d/${name}":
        ensure      => $ensure,
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'system_cron_spool_t',
        content     => $content,
        source      => $source,
    }

}

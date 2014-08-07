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
#   named "$location/$name".  See also the "location" parameter.
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
# [*location*]
#   File system path to where the cron job file is to be installed.  Defaults
#   to "/etc/cron.d" which is appropriate for most job files.  See also the
#   "namevar" parameter.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   John Florian <john.florian@dart.biz>


define cron::jobfile (
        $ensure='present',
        $content=undef,
        $source=undef,
        $location='/etc/cron.d',
    ) {

    include 'cron::params'

    file { "${location}/${name}":
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

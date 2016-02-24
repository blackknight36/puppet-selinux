# modules/facter/manifests/init.pp
#
# Synopsis:
#       Installs a custom fact into the facter namespace.
#
# Parameters:
#       name:           The name of the web site.
#       source:         The puppet URI for obtaining the custom fact file.
#
# Requires:
#       NONE
#
# ATTENTION:
#       This is a kludge around some horrible bugs in puppet-2.6.6 (and
#       likely, all prior versions) when using the recommended pluginsync
#       approach for distribution of custom facts and types.
#
#       Those bugs are:
#               - facter spawns at least one zombie per run
#               - facts get pushed once to nodes, but stagnate thereafter
#
#       This definition is only marginally better:
#               - convergence cannot be achieved in less than two runs
#               - dependencies must be coded in reverse using 'before' as
#               shown in the example below as opposed to 'require'
#
# Bugs:
#       Despite the bugs notes here, this is still a better alternative to
#       the built-in and recommended approach for puppet-2.6.6 (and earlier).
#
#       Convergence requires at least two catalog applications.  The first
#       application will realize extisting facts and only afterwards install
#       the new custom fact file.  Values from that new fact will first be
#       available on the second catalog application (or "run" if you prefer).
#
# Example usage:
#
#       facter::custom-fact { 'example':
#           before  => Class['WHERE_USED'],
#           source  => 'puppet:///private-domain/facter/example.rb',
#       }


define facter::custom-fact ($ensure='present', $source) {

    file { "${rubysitedir}/facter/local":
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seluser => 'unconfined_u',
        selrole => 'object_r',
        seltype => 'file_t',
    }

    file { "custom-fact-${name}":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        path    => "${rubysitedir}/facter/local/${name}.rb",
        require => File["${rubysitedir}/facter/local"],
        seluser => 'unconfined_u',
        selrole => 'object_r',
        seltype => 'file_t',
        source  => "${source}",
    }

}

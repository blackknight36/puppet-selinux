# modules/koji/manifests/mash_repo.pp
#
# == Define: koji::mash_repo
#
# Manages a repository configuration file for Koji's mash client.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   An arbitrary identifier for the mash_repo instance unless the "repo_name"
#   parameter is not set in which case this must provide the value normally
#   set with the "repo_name" parameter.
#
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*repo_name*]
#   This may be used in place of "namevar" if it's beneficial to give namevar
#   an arbitrary value.
#
# [*content*]
#   Literal content for the repository configuration file.  If neither
#   "content" nor "source" is given, the content of the file will be left
#   unmanaged.
#
# [*source*]
#   URI of the repository configuration file content.  If neither "content"
#   nor "source" is given, the content of the file will be left unmanaged.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define koji::mash_repo (
        $ensure='present',
        $repo_name=undef,
        $content=undef,
        $source=undef,
    ) {

    include '::koji::params'

    if $repo_name {
        $repo_name_ = $repo_name
    } else {
        $repo_name_ = $name
    }

    file { "${::koji::params::our_mashes}/${repo_name_}.mash":
        ensure    => $ensure,
        owner     => 'root',
        group     => 'root',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        require   => Class['koji::mash'],
        subscribe => Package[$::koji::params::mash_packages],
        content   => $content,
        source    => $source,
    }

}

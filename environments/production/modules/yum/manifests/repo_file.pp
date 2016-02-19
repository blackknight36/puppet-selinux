# modules/yum/manifests/repo_file.pp
#
# Synopsis:
#       Installs a repository configuration for yum.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       source                  URI referencing the directory containing
#                               $name.


define yum::repo_file($source) {

    file { "/etc/yum.repos.d/${name}":
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        source  => "${source}/${name}",

    }

}

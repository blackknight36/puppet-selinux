# modules/yum/manifests/init.pp
#
# Synopsis:
#       Configures YUM on a host.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       conf_source             URI for main yum.conf content.

class yum ($conf_source) {

    file { '/etc/yum.conf':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        source  => $conf_source,
    }

}

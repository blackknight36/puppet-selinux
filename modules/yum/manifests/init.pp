# modules/yum/manifests/init.pp

class yum {

    # Stage => first

    file { '/etc/yum.conf':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        source  => [
            'puppet:///private-host/yum/yum.conf',
            'puppet:///private-domain/yum/yum.conf',
            'puppet:///modules/yum/yum.conf',
        ],
    }

    include 'yum::fedora'
    include 'yum::mdct'
    include 'yum::rpmfusion'

}

# modules/yum/manifests/init.pp
#
# == Class: yum
#
# Manages yum on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*deltarpm*]
#   See 'deltarpm' in yum.conf(5).
#
# [*http_caching*]
#   See 'http_caching' in yum.conf(5).
#
# [*proxy*]
#   See 'proxy' in yum.conf(5).
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


class yum (
        $deltarpm=undef,
        $http_caching=undef,
        $proxy=undef,
    ) {

    file { '/etc/yum.conf':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        content => template('yum/yum.conf.erb'),
    }

}

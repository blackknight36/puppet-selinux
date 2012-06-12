# modules/apache/manifests/definitions/bind-mount.pp
#
# Synopsis:
#       Bind mounts a directory structure under the standard web server root
#       (/var/www/) so as to comply with SE Linux policy.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            mount point under /var/www
#       ensure          mounted         instance is to be one of: absent,
#                                       defined, unmounted, or mounted
#       source                          directory to be mounted at *name*
#
# Requires:
#       Class['apache']
#
# Example usage:
#
#       include 'apache'
#
#       apache::bind-mount { 'html':
#           source  => '/mnt/resources/www/html/',
#       }

define apache::bind-mount ($ensure='mounted', $source) {

    file { "/var/www/${name}":
        ensure  => directory,
# These are disabled because they cause puppet failure once the mount is in
# effect.  This is probably a bug that should be reported since 'replace' is
# of no help here.
#       owner   => 'root',
#       group   => 'root',
#       mode    => '0755',
        replace => false,
        seluser => 'system_u',
        selrole => 'object_r',
# Disabling seltype for now since the value doesn't stick at all.
# TODO: revisit this once SELinux is available on NFS server.
#       seltype => 'httpd_sys_content_t',
        require => Package['httpd'],
    }

    mount { "/var/www/${name}":
        atboot  => true,
        before  => Service['httpd'],
        device  => $source,
        ensure  => $ensure,
        fstype  => 'none',
        options => 'bind,_netdev,context=system_u:object_r:httpd_sys_content_t',
        require => File["/var/www/${name}"],
    }


}

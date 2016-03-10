# modules/collectd/manifests/init.pp
#
# == Class: collectd
#
# This class manages packages and settings for the collectd process. 
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>


class collectd() {
    
    include 'collectd::params'

}

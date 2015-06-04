# modules/dart/manifests/tc_util.pp
#
# == Class: dart::tc_util
#
# Configures a host as a general purpose utility server for the TeamCenter
# users.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::tc_util inherits dart::abstract::guarded_server_node {

    tag 'tc_util'

    include 'dart::abstract::packages::developer'
    include 'dart::subsys::teamcenter::git'
    include 'dart::subsys::teamcenter::sync'
    include 'dart::subsys::yum_cron'

}

# modules/dart/manifests/mdct_dev26.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Tao Wang

class dart::mdct_dev26 inherits dart::abstract::workstation_node {
    include 'dart::subsys::yum_cron'
}

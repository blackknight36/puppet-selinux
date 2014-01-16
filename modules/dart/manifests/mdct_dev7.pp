# modules/dart/manifests/mdct_dev7.pp
#
# Synopsis:
#       Technician Workstation
#
# Contact:
#       Chris Rockhold

class dart::mdct_dev7 inherits dart::abstract::workstation_node {
    include 'dart::subsys::yum_cron'
}

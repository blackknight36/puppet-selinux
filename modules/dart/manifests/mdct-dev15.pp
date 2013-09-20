# modules/dart/manifests/mdct-dev15.pp
#
# Synopsis:
#       Technician Workstation
#
# Contact:
#       Roger Brunk

class dart::mdct-dev15 inherits dart::abstract::workstation_node {
    include 'dart::subsys::yum_cron'
}

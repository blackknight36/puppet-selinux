# modules/dart/manifests/mdct-dev11.pp
#
# Synopsis:
#       Technician Workstation
#
# Contact:
#       Chris Pugh

class dart::mdct-dev11 inherits dart::abstract::workstation_node {
    include packages::kde
    include 'dart::subsys::yum_cron'
}

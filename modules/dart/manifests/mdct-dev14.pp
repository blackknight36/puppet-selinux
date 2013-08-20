# modules/dart/manifests/mdct-dev14.pp
#
# Synopsis:
#       Technician Workstation
#
# Contact:
#       Adam Harris

class dart::mdct-dev14 inherits dart::abstract::workstation_node {
    include packages::kde
    include 'dart::subsys::yum_cron'
}

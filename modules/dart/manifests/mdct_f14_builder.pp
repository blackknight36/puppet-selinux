# modules/dart/manifests/mdct_f14_builder.pp
#
# Synopsis:
#       Package Builder for Fedora 14 Release
#
# Contact:
#       John Florian

class dart::mdct_f14_builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
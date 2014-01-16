# modules/dart/manifests/mdct_f17_builder.pp
#
# Synopsis:
#       Package Builder for Fedora 17 Release
#
# Contact:
#       John Florian

class dart::mdct_f17_builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}

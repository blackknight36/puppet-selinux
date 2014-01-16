# modules/dart/manifests/mdct-f19-builder.pp
#
# Synopsis:
#       Package Builder for Fedora 19 Release
#
# Contact:
#       John Florian

class dart::mdct_f19_builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}

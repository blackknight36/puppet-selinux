# modules/dart/manifests/mdct-f14-builder.pp
#
# Synopsis:
#       Package Builder for Fedora 14 Release
#
# Contact:
#       John Florian

class dart::mdct-f14-builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}

# modules/dart/manifests/mdct-f13-builder.pp
#
# Synopsis:
#       Package Builder for Fedora 13 Release
#
# Contact:
#       John Florian

class dart::mdct-f13-builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}

# modules/dart/manifests/mdct-f18-builder.pp
#
# Synopsis:
#       Package Builder for Fedora 18 Release
#
# Contact:
#       John Florian

class dart::mdct-f18-builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}

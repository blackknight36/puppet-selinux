# modules/dart/manifests/mdct_ovirt_engine.pp
#
# Synopsis:
#       oVirt Engine (manages oVirt nodes, which host team VMs)
#
# Contact:
#       Levi Harper

class dart::mdct_ovirt_engine inherits dart::abstract::ovirt_node {


# Lot's of churn with repo naming / configuration - do it manually for now
#    include 'dart::subsys::yum::ovirt'

}

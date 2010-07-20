# /etc/puppet/manifests/nodes.pp

# This file only contains node/class associations.  Every host now gets its
# own class which should inherit one of the node-type classes.  All such
# classes are in the dart module (see modules/dart/manifests/classes/*.pp).

node "mdct-00dw.dartcontainer.com"              { include dart::mdct-00dw }
node "mdct-dev6.dartcontainer.com"              { include dart::mdct-dev6 }             # CK
node "mdct-dev9.dartcontainer.com"              { include dart::mdct-dev9 }             # MK
node "mdct-dev11.dartcontainer.com"             { include dart::mdct-dev11 }            # CP
node "mdct-dev12.dartcontainer.com"             { include dart::mdct-dev12 }            # JF
node "mdct-dev13.dartcontainer.com"             { include dart::mdct-dev13 }            # BS
node "mdct-dev14.dartcontainer.com"             { include dart::mdct-dev14 }            # AH
node "mdct-f8-builder.dartcontainer.com"        { include dart::mdct-f8-builder }
node "mdct-f10-builder.dartcontainer.com"       { include dart::mdct-f10-builder }
node "mdct-f11-builder.dartcontainer.com"       { include dart::mdct-f11-builder }
node "mdct-f12-builder.dartcontainer.com"       { include dart::mdct-f12-builder }
node "mdct-f13-builder.dartcontainer.com"       { include dart::mdct-f13-builder }
node "mdct-puppet.dartcontainer.com"            { include dart::mdct-puppet }
node "mdct-test-agent-32.dartcontainer.com"     { include dart::mdct-test-agent-32 }
node "mole.dartcontainer.com"                   { include dart::mole }
node "mole-dev.dartcontainer.com"               { include dart::mole-dev }

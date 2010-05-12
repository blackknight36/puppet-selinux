# /etc/puppet/manifests/nodes.pp

# This file only contains node/class associations.  Every host now gets its
# own class which should inherit one of the node-type classes.  All such
# classes are in the dart module (see modules/dart/manifests/classes/*.pp).

node "mdct-00dw.dartcontainer.com"              { include dart::mdct-00dw }
node "mdct-dev6.dartcontainer.com"              { include dart::mdct-dev6 }
node "mdct-dev9.dartcontainer.com"              { include dart::mdct-dev9 }
node "mdct-dev12.dartcontainer.com"             { include dart::mdct-dev12 }
node "mdct-dev13.dartcontainer.com"             { include dart::mdct-dev13 }
node "mdct-f8-builder.dartcontainer.com"        { include dart::mdct-f8-builder }
node "mdct-f10-builder.dartcontainer.com"       { include dart::mdct-f10-builder }
node "mdct-f12-builder.dartcontainer.com"       { include dart::mdct-f12-builder }
node "mdct-puppet.dartcontainer.com"            { include dart::mdct-puppet }
node "mdct-test-agent-32.dartcontainer.com"     { include dart::mdct-test-agent-32 }
node "mole.dartcontainer.com"                   { include dart::mole }
node "mole-dev.dartcontainer.com"               { include dart::mole-dev }

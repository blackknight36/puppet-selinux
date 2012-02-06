# manifests/nodes.pp

# This file only contains node/class associations.  Every host now gets its
# own class which should inherit one of the abstract node-type classes.  All
# such classes are in the dart module (see
# modules/dart/manifests/classes/abstract/*.pp).

node "jflo-f13.dartcontainer.com"               { include dart::jflo-f13 }
node "mdct-00bk.dartcontainer.com"              { include dart::mdct-00bk }
node "mdct-00dw.dartcontainer.com"              { include dart::mdct-00dw }
node "mdct-00fs.dartcontainer.com"              { include dart::mdct-00fs }
node "mdct-00sw.dartcontainer.com"              { include dart::mdct-00sw }
node "mdct-02ut.dartcontainer.com"              { include dart::mdct-02ut }
node "mdct-03pt.dartcontainer.com"              { include dart::mdct-03pt }
node "mdct-04pt.dartcontainer.com"              { include dart::mdct-04pt }
node "mdct-15pt.dartcontainer.com"              { include dart::mdct-15pt }
node "mdct-19pt.dartcontainer.com"              { include dart::mdct-19pt }
node "mdct-39pt.dartcontainer.com"              { include dart::mdct-39pt }
node "mdct-aos-master-f15.dartcontainer.com"    { include dart::mdct-aos-master-f15 }
node "mdct-ci-agent1.dartcontainer.com"         { include dart::mdct-ci-agent1 }
node "mdct-dev6-test.dartcontainer.com"         { include dart::mdct-dev6-test }        # CK TEST
node "mdct-dev6.dartcontainer.com"              { include dart::mdct-dev6 }             # CK
node "mdct-dev7.dartcontainer.com"              { include dart::mdct-dev7 }             # CR
node "mdct-dev10.dartcontainer.com"             { include dart::mdct-dev10 }            # LH
node "mdct-dev11.dartcontainer.com"             { include dart::mdct-dev11 }            # CP
node "mdct-dev12.dartcontainer.com"             { include dart::mdct-dev12 }            # JF
node "mdct-dev13.dartcontainer.com"             { include dart::mdct-dev13 }            # BS
node "mdct-dev14.dartcontainer.com"             { include dart::mdct-dev14 }            # AH
node "mdct-dev16.dartcontainer.com"             { include dart::mdct-dev16 }            # BM
node "mdct-est-ci.dartcontainer.com"            { include dart::mdct-est-ci }
node "mdct-est-dev1.dartcontainer.com"          { include dart::mdct-est-dev1 }
node "mdct-est-dev2.dartcontainer.com"          { include dart::mdct-est-dev2 }
node "mdct-f8-builder.dartcontainer.com"        { include dart::mdct-f8-builder }
node "mdct-f10-builder.dartcontainer.com"       { include dart::mdct-f10-builder }
node "mdct-f11-builder.dartcontainer.com"       { include dart::mdct-f11-builder }
node "mdct-f12-builder.dartcontainer.com"       { include dart::mdct-f12-builder }
node "mdct-f13-builder.dartcontainer.com"       { include dart::mdct-f13-builder }
node "mdct-f14-builder.dartcontainer.com"       { include dart::mdct-f14-builder }
node "mdct-f15-builder.dartcontainer.com"       { include dart::mdct-f15-builder }
node "mdct-f16-builder.dartcontainer.com"       { include dart::mdct-f16-builder }
node "mdct-puppet.dartcontainer.com"            { include dart::mdct-puppet }
node "mdct-test-agent-32.dartcontainer.com"     { include dart::mdct-test-agent-32 }
node "mole-dev.dartcontainer.com"               { include dart::mole-dev }
node "mole.dartcontainer.com"                   { include dart::mole }

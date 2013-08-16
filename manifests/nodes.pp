# manifests/nodes.pp

# This file only contains node/class associations.  Every host now gets its
# own class which should inherit one of the abstract node-type classes.  All
# such classes are in the dart module (see
# modules/dart/manifests/classes/abstract/*.pp).

node 'mdct-00bk.dartcontainer.com'              { include dart::mdct-00bk }
node 'mdct-00dtl.dartcontainer.com'             { include dart::mdct-00dtl }
node 'mdct-00tl.dartcontainer.com'              { include dart::mdct-00tl }
node 'mdct-00dw.dartcontainer.com'              { include dart::mdct-00dw }
node 'mdct-00fs.dartcontainer.com'              { include dart::mdct-00fs }
node 'mdct-00sw.dartcontainer.com'              { include dart::mdct-00sw }
node 'mdct-02ut.dartcontainer.com'              { include dart::mdct-02ut }
node 'mdct-01pt.dartcontainer.com'              { include dart::mdct-01pt }
node 'mdct-03pt.dartcontainer.com'              { include dart::mdct-03pt }
node 'mdct-04pt.dartcontainer.com'              { include dart::mdct-04pt }
node 'mdct-15pt.dartcontainer.com'              { include dart::mdct-15pt }
node 'mdct-19pt.dartcontainer.com'              { include dart::mdct-19pt }
node 'mdct-25pt.dartcontainer.com'              { include dart::mdct-25pt }
node 'mdct-39pt.dartcontainer.com'              { include dart::mdct-39pt }
node 'mdct-47pi.dartcontainer.com'              { include dart::mdct-47pi }
node 'mdct-55pt.dartcontainer.com'              { include dart::mdct-55pt }
node 'mdct-75pt.dartcontainer.com'              { include dart::mdct-75pt }
node 'mdct-76pt.dartcontainer.com'              { include dart::mdct-76pt }
node 'mdct-77pt.dartcontainer.com'              { include dart::mdct-77pt }
node 'mdct-99pi.dartcontainer.com'              { include dart::mdct-99pi }
node 'mdct-0314pi.dartcontainer.com'            { include dart::mdct-0314pi }
node 'mdct-recov.dartcontainer.com'             { include dart::mdct-recov }
node 'mdct-pt-dbtest.dartcontainer.com'         { include dart::mdct-pt-dbtest }
node 'mdct-aos-master-f15.dartcontainer.com'    { include dart::mdct-aos-master-f15 }
node 'mdct-aos-master-f19.dartcontainer.com'    { include dart::mdct-aos-master-f19 }
node 'mdct-ci-agent1.dartcontainer.com'         { include dart::mdct-ci-agent1 }
node 'mdct-dev6-test.dartcontainer.com'         { include dart::mdct-dev6-test }        # CK TEST
node 'mdct-dev6.dartcontainer.com'              { include dart::mdct-dev6 }             # CK
node 'mdct-dev7.dartcontainer.com'              { include dart::mdct-dev7 }             # CR
node 'mdct-dev9.dartcontainer.com'              { include dart::mdct-dev9 }             # NN
node 'mdct-dev10.dartcontainer.com'             { include dart::mdct-dev10 }            # LH
node /^mdct-dev10-.*\.dartcontainer\.com$/      { include dart::mdct-dev10-srvr }       # LH's servers
node 'mdct-dev11.dartcontainer.com'             { include dart::mdct-dev11 }            # CP
node 'mdct-dev12.dartcontainer.com'             { include dart::mdct-dev12 }            # JF
node 'mdct-dev14.dartcontainer.com'             { include dart::mdct-dev14 }            # AH
node 'mdct-dev15.dartcontainer.com'             { include dart::mdct-dev15 }            # RB
node 'mdct-dev16.dartcontainer.com'             { include dart::mdct-dev16 }            # BM
node 'mdct-dev17.dartcontainer.com'             { include dart::mdct-dev17 }            # CB
node 'mdct-dr.dartcontainer.com'                { include dart::mdct-dr }
node 'mdct-dr-dev.dartcontainer.com'            { include dart::mdct-dr-dev }
node 'mdct-est-ci.dartcontainer.com'            { include dart::mdct-est-ci }
node 'mdct-est-dev1.dartcontainer.com'          { include dart::mdct-est-dev1 }
node 'mdct-est-dev2.dartcontainer.com'          { include dart::mdct-est-dev2 }
node 'mdct-f13-builder.dartcontainer.com'       { include dart::mdct-f13-builder }
node 'mdct-f14-builder.dartcontainer.com'       { include dart::mdct-f14-builder }
node 'mdct-f15-builder.dartcontainer.com'       { include dart::mdct-f15-builder }
node 'mdct-f16-builder.dartcontainer.com'       { include dart::mdct-f16-builder }
node 'mdct-f17-builder.dartcontainer.com'       { include dart::mdct-f17-builder }
node 'mdct-f18-builder.dartcontainer.com'       { include dart::mdct-f18-builder }
node 'mdct-f19-builder.dartcontainer.com'       { include dart::mdct-f19-builder }
node 'mdct-ngic.dartcontainer.com'              { include dart::mdct-ngic }
node 'mdct-ngic-dev.dartcontainer.com'          { include dart::mdct-ngic-dev }
node 'mdct-ovirt-engine.dartcontainer.com'      { include 'dart::mdct_ovirt_engine' }
node /^mdct-ovirt-node-.*\.dartcontainer\.com$/ { include 'dart::mdct_ovirt_node' }
node 'mdct-puppet.dartcontainer.com'            { include dart::mdct-puppet }
node 'mdct-tc.dartcontainer.com'                { include dart::mdct-tc }
node 'mdct-test-agent-32.dartcontainer.com'     { include dart::mdct-test-agent-32 }
node 'mole-dev.dartcontainer.com'               { include dart::mole-dev }
node 'mole.dartcontainer.com'                   { include dart::mole }
node 'tc-util.dartcontainer.com'                { include dart::tc-util }

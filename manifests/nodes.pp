# manifests/nodes.pp
# vim: tw=90

# This file only contains node/class associations.  Every host now gets its
# own class which should inherit one of the abstract node-type classes.  All
# such classes are in the dart module (see
# modules/dart/manifests/classes/abstract/*.pp).

node 'mdct-00bk.dartcontainer.com'              { include 'dart::mdct-00bk' }
node 'mdct-00dtl.dartcontainer.com'             { include 'dart::mdct-00dtl' }
node 'mdct-00dw.dartcontainer.com'              { include 'dart::mdct-00dw' }
node 'mdct-00fs.dartcontainer.com'              { include 'dart::mdct-00fs' }
node 'mdct-00sw.dartcontainer.com'              { include 'dart::mdct-00sw' }
node 'mdct-00tl.dartcontainer.com'              { include 'dart::mdct-00tl' }
node 'mdct-01pt.dartcontainer.com'              { include 'dart::mdct-01pt' }
node 'mdct-02ut.dartcontainer.com'              { include 'dart::mdct-02ut' }
node 'mdct-03pt.dartcontainer.com'              { include 'dart::mdct-03pt' }
node 'mdct-03ut.dartcontainer.com'              { include 'dart::mdct-03ut' }
node 'mdct-04pt.dartcontainer.com'              { include 'dart::mdct-04pt' }
node 'mdct-10ut.dartcontainer.com'              { include 'dart::mdct-10ut' }
node 'mdct-15pt.dartcontainer.com'              { include 'dart::mdct-15pt' }
node 'mdct-19pt.dartcontainer.com'              { include 'dart::mdct-19pt' }
node 'mdct-19ut.dartcontainer.com'              { include 'dart::mdct-19ut' }
node 'mdct-25pt.dartcontainer.com'              { include 'dart::mdct-25pt' }
node 'mdct-39pt.dartcontainer.com'              { include 'dart::mdct-39pt' }
node 'mdct-47pt.dartcontainer.com'              { include 'dart::mdct_47pt' }
node 'mdct-47pi.dartcontainer.com'              { include 'dart::mdct-47pi' }
node 'mdct-55pt.dartcontainer.com'              { include 'dart::mdct-55pt' }
node 'mdct-75pt.dartcontainer.com'              { include 'dart::mdct-75pt' }
node 'mdct-76pt.dartcontainer.com'              { include 'dart::mdct-76pt' }
node 'mdct-77pt.dartcontainer.com'              { include 'dart::mdct-77pt' }
node 'mdct-99pi.dartcontainer.com'              { include 'dart::mdct-99pi' }
node 'mdct-0302pi.dartcontainer.com'            { include 'dart::mdct-0302pi' }
node 'mdct-0310pi.dartcontainer.com'            { include 'dart::mdct-0310pi' }
node 'mdct-0314pi.dartcontainer.com'            { include 'dart::mdct-0314pi' }
node 'mdct-aos-master-f15.dartcontainer.com'    { include 'dart::mdct-aos-master-f15' }
node 'mdct-aos-master-f19.dartcontainer.com'    { include 'dart::mdct-aos-master-f19' }
node 'mdct-ci-agent1.dartcontainer.com'         { include 'dart::mdct-ci-agent1' }
node 'mdct-dev6-test.dartcontainer.com'         { include 'dart::mdct-dev6-test' }
node 'mdct-dev6.dartcontainer.com'              { include 'dart::mdct-dev6' }
node 'mdct-dev7.dartcontainer.com'              { include 'dart::mdct-dev7' }
node 'mdct-dev9.dartcontainer.com'              { include 'dart::mdct-dev9' }
node 'mdct-dev10.dartcontainer.com'             { include 'dart::mdct-dev10' }
node 'mdct-dev11.dartcontainer.com'             { include 'dart::mdct-dev11' }
node 'mdct-dev12.dartcontainer.com'             { include 'dart::mdct-dev12' }
node 'mdct-dev16.dartcontainer.com'             { include 'dart::mdct-dev16' }
node 'mdct-dev17.dartcontainer.com'             { include 'dart::mdct-dev17' }
node 'mdct-dev18.dartcontainer.com'             { include 'dart::mdct-dev18' }
node 'mdct-dev19.dartcontainer.com'             { include 'dart::mdct-dev19' }
node 'mdct-dr-dev.dartcontainer.com'            { include 'dart::mdct-dr-dev' }
node 'mdct-dr.dartcontainer.com'                { include 'dart::mdct-dr' }
node 'mdct-est-ci.dartcontainer.com'            { include 'dart::mdct-est-ci' }
node 'mdct-est-dev1.dartcontainer.com'          { include 'dart::mdct-est-dev1' }
node 'mdct-est-dev2.dartcontainer.com'          { include 'dart::mdct-est-dev2' }
node 'mdct-f13-builder.dartcontainer.com'       { include 'dart::mdct-f13-builder' }
node 'mdct-f14-builder.dartcontainer.com'       { include 'dart::mdct-f14-builder' }
node 'mdct-f15-builder.dartcontainer.com'       { include 'dart::mdct-f15-builder' }
node 'mdct-f16-builder.dartcontainer.com'       { include 'dart::mdct-f16-builder' }
node 'mdct-f17-builder.dartcontainer.com'       { include 'dart::mdct-f17-builder' }
node 'mdct-f18-builder.dartcontainer.com'       { include 'dart::mdct-f18-builder' }
node 'mdct-f19-builder.dartcontainer.com'       { include 'dart::mdct-f19-builder' }
node 'mdct-koji.dartcontainer.com'              { include 'dart::mdct_koji' }
node 'mdct-ngic-dev.dartcontainer.com'          { include 'dart::mdct-ngic-dev' }
node 'mdct-ngic.dartcontainer.com'              { include 'dart::mdct-ngic' }
node 'mdct-ovirt-engine.dartcontainer.com'      { include 'dart::mdct_ovirt_engine' }
node 'mdct-pt-dbtest.dartcontainer.com'         { include 'dart::mdct-pt-dbtest' }
node 'mdct-recov.dartcontainer.com'             { include 'dart::mdct-recov' }
node 'mdct-tc.dartcontainer.com'                { include 'dart::mdct-tc' }
node 'mdct-teamcity.dartcontainer.com'          { include 'dart::mdct_teamcity' }
node 'mdct-teamcity-agent1.dartcontainer.com'   { include 'dart::mdct_teamcity_agent1' }
node 'mdct-test-agent-32.dartcontainer.com'     { include 'dart::mdct-test-agent-32' }
node 'mole-dev.dartcontainer.com'               { include 'dart::mole-dev' }
node 'mole.dartcontainer.com'                   { include 'dart::mole' }
node 'tc-util.dartcontainer.com'                { include 'dart::tc-util' }

node /^mdct-dev10-.*\.dartcontainer\.com$/      { include 'dart::mdct-dev10-srvr' }
node /^mdct-ovirt-node-.*\.dartcontainer\.com$/ { include 'dart::mdct_ovirt_node' }
node /^mdct-puppet.*\.dartcontainer\.com$/      { include 'dart::mdct-puppet' }

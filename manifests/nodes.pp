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
node 'mdct-55pt.dartcontainer.com'              { include 'dart::mdct_55pt' }
node 'mdct-75pt.dartcontainer.com'              { include 'dart::mdct_75pt' }
node 'mdct-76pt.dartcontainer.com'              { include 'dart::mdct_76pt' }
node 'mdct-77pt.dartcontainer.com'              { include 'dart::mdct_77pt' }
node 'mdct-99pi.dartcontainer.com'              { include 'dart::mdct_99pi' }
node 'mdct-0302pi.dartcontainer.com'            { include 'dart::mdct-0302pi' }
node 'mdct-0310pi.dartcontainer.com'            { include 'dart::mdct-0310pi' }
node 'mdct-0314pi.dartcontainer.com'            { include 'dart::mdct-0314pi' }
node 'mdct-aos-master-f15.dartcontainer.com'    { include 'dart::mdct_aos_master_f15' }
node 'mdct-aos-master-f19.dartcontainer.com'    { include 'dart::mdct_aos_master_f19' }
node 'mdct-ci-agent1.dartcontainer.com'         { include 'dart::mdct_ci_agent1' }
node 'mdct-dev6-test.dartcontainer.com'         { include 'dart::mdct_dev6_test' }
node 'mdct-dev6.dartcontainer.com'              { include 'dart::mdct_dev6' }
node 'mdct-dev7.dartcontainer.com'              { include 'dart::mdct_dev7' }
node 'mdct-dev9.dartcontainer.com'              { include 'dart::mdct_dev9' }
node 'mdct-dev10.dartcontainer.com'             { include 'dart::mdct_dev10' }
node 'mdct-dev11.dartcontainer.com'             { include 'dart::mdct_dev11' }
node 'mdct-dev12.dartcontainer.com'             { include 'dart::mdct_dev12' }
node 'mdct-dev16.dartcontainer.com'             { include 'dart::mdct_dev16' }
node 'mdct-dev17.dartcontainer.com'             { include 'dart::mdct_dev17' }
node 'mdct-dev18.dartcontainer.com'             { include 'dart::mdct_dev18' }
node 'mdct-dev19.dartcontainer.com'             { include 'dart::mdct_dev19' }
node 'mdct-dr-dev.dartcontainer.com'            { include 'dart::mdct_dr_dev' }
node 'mdct-dr.dartcontainer.com'                { include 'dart::mdct_dr' }
node 'mdct-est-ci.dartcontainer.com'            { include 'dart::mdct_est_ci' }
node 'mdct-est-dev1.dartcontainer.com'          { include 'dart::mdct_est_dev1' }
node 'mdct-est-dev2.dartcontainer.com'          { include 'dart::mdct_est_dev2' }
node 'mdct-f13-builder.dartcontainer.com'       { include 'dart::mdct-f13-builder' }
node 'mdct-f14-builder.dartcontainer.com'       { include 'dart::mdct_f14_builder' }
node 'mdct-f15-builder.dartcontainer.com'       { include 'dart::mdct_f15_builder' }
node 'mdct-f16-builder.dartcontainer.com'       { include 'dart::mdct_f16_builder' }
node 'mdct-f17-builder.dartcontainer.com'       { include 'dart::mdct_f17_builder' }
node 'mdct-f18-builder.dartcontainer.com'       { include 'dart::mdct_f18_builder' }
node 'mdct-f19-builder.dartcontainer.com'       { include 'dart::mdct_f19_builder' }
node 'mdct-f20-builder.dartcontainer.com'       { include 'dart::mdct_f20_builder' }
node 'mdct-koji.dartcontainer.com'              { include 'dart::mdct_koji' }
node 'mdct-ngic-dev.dartcontainer.com'          { include 'dart::mdct_ngic_dev' }
node 'mdct-ngic.dartcontainer.com'              { include 'dart::mdct_ngic' }
node 'mdct-ovirt-engine.dartcontainer.com'      { include 'dart::mdct_ovirt_engine' }
node 'mdct-pt-dbtest.dartcontainer.com'         { include 'dart::mdct_pt_dbtest' }
node 'mdct-recov.dartcontainer.com'             { include 'dart::mdct_recov' }
node 'mdct-tc.dartcontainer.com'                { include 'dart::mdct_tc' }
node 'mdct-teamcity.dartcontainer.com'          { include 'dart::mdct_teamcity' }
node 'mdct-teamcity-agent1.dartcontainer.com'   { include 'dart::mdct_teamcity_agent1' }
node 'mdct-test-agent-32.dartcontainer.com'     { include 'dart::mdct_test_agent_32' }
node 'mole-dev.dartcontainer.com'               { include 'dart::mole_dev' }
node 'mole.dartcontainer.com'                   { include 'dart::mole' }
node 'tc-util.dartcontainer.com'                { include 'dart::tc_util' }

node /^mdct-dev10-.*\.dartcontainer\.com$/      { include 'dart::mdct_dev10_srvr' }
node /^mdct-ovirt-node-.*\.dartcontainer\.com$/ { include 'dart::mdct_ovirt_node' }
node /^mdct-puppet.*\.dartcontainer\.com$/      { include 'dart::mdct_puppet' }

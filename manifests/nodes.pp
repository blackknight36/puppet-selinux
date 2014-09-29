# manifests/nodes.pp
# vim: tw=90

# Bring in the domain-level parameters that transcend classes and modules.
include 'dart::params'

# Now associate host names with their corresponding class.  Since this is handled on a
# first match wins basis, our strategy is start with very specific associations and finish
# with generalized associations.

#
# This section must consist only of very specific host:class relations on a 1:1 basis.
#
node 'mdct-00bk.dartcontainer.com'              { include 'dart::mdct_00bk' }
node 'mdct-00dtl.dartcontainer.com'             { include 'dart::mdct_00dtl' }
node 'mdct-00dw.dartcontainer.com'              { include 'dart::mdct_00dw' }
node 'mdct-00fs.dartcontainer.com'              { include 'dart::mdct_00fs' }
node 'mdct-00sw.dartcontainer.com'              { include 'dart::mdct_00sw' }
node 'mdct-00tl.dartcontainer.com'              { include 'dart::mdct_00tl' }
node 'mdct-00pi.dartcontainer.com'              { include 'dart::mdct_00pi' }
node 'mdct-01pi.dartcontainer.com'              { include 'dart::mdct_01pi' }
node 'mdct-01pt.dartcontainer.com'              { include 'dart::mdct_01pt' }
node 'mdct-02pi.dartcontainer.com'              { include 'dart::mdct_02pi' }
node 'mdct-0302pi.dartcontainer.com'            { include 'dart::mdct_0302pi' }
node 'mdct-0302pt.dartcontainer.com'            { include 'dart::mdct_0302pt' }
node 'mdct-0310pi.dartcontainer.com'            { include 'dart::mdct_0310pi' }
node 'mdct-0310pt.dartcontainer.com'            { include 'dart::mdct_0310pt' }
node 'mdct-0314pi.dartcontainer.com'            { include 'dart::mdct_0314pi' }
node 'mdct-03pi.dartcontainer.com'              { include 'dart::mdct_03pi' }
node 'mdct-03pt.dartcontainer.com'              { include 'dart::mdct_03pt' }
node 'mdct-04pi.dartcontainer.com'              { include 'dart::mdct_04pi' }
node 'mdct-04pt.dartcontainer.com'              { include 'dart::mdct_04pt' }
node 'mdct-05pi.dartcontainer.com'              { include 'dart::mdct_05pi' }
node 'mdct-05pt.dartcontainer.com'              { include 'dart::mdct_05pt' }
node 'mdct-10pi.dartcontainer.com'              { include 'dart::mdct_10pi' }
node 'mdct-10pt.dartcontainer.com'              { include 'dart::mdct_10pt' }
node 'mdct-11pi.dartcontainer.com'              { include 'dart::mdct_11pi' }
node 'mdct-15pi.dartcontainer.com'              { include 'dart::mdct_15pi' }
node 'mdct-15pt.dartcontainer.com'              { include 'dart::mdct_15pt' }
node 'mdct-19pt.dartcontainer.com'              { include 'dart::mdct_19pt' }
node 'mdct-25pi.dartcontainer.com'              { include 'dart::mdct_25pi' }
node 'mdct-25pt.dartcontainer.com'              { include 'dart::mdct_25pt' }
node 'mdct-39pi.dartcontainer.com'              { include 'dart::mdct_39pi' }
node 'mdct-39pt.dartcontainer.com'              { include 'dart::mdct_39pt' }
node 'mdct-47pi.dartcontainer.com'              { include 'dart::mdct_47pi' }
node 'mdct-47pt.dartcontainer.com'              { include 'dart::mdct_47pt' }
node 'mdct-52pi.dartcontainer.com'              { include 'dart::mdct_52pi' }
node 'mdct-55pi.dartcontainer.com'              { include 'dart::mdct_55pi' }
node 'mdct-55pt.dartcontainer.com'              { include 'dart::mdct_55pt' }
node 'mdct-72pi.dartcontainer.com'              { include 'dart::mdct_72pi' }
node 'mdct-73pi.dartcontainer.com'              { include 'dart::mdct_73pi' }
node 'mdct-73pt.dartcontainer.com'              { include 'dart::mdct_73pt' }
node 'mdct-75pi.dartcontainer.com'              { include 'dart::mdct_75pi' }
node 'mdct-75pt.dartcontainer.com'              { include 'dart::mdct_75pt' }
node 'mdct-76pi.dartcontainer.com'              { include 'dart::mdct_76pi' }
node 'mdct-76pt.dartcontainer.com'              { include 'dart::mdct_76pt' }
node 'mdct-77pi.dartcontainer.com'              { include 'dart::mdct_77pi' }
node 'mdct-77pt.dartcontainer.com'              { include 'dart::mdct_77pt' }
node 'mdct-78pi.dartcontainer.com'              { include 'dart::mdct_78pi' }
node 'mdct-78pt.dartcontainer.com'              { include 'dart::mdct_78pt' }
node 'mdct-99pi.dartcontainer.com'              { include 'dart::mdct_99pi' }
node 'mdct-99pi-x.dartcontainer.com'            { include 'dart::mdct_99pi_x' }
node 'mdct-aos-master-f19.dartcontainer.com'    { include 'dart::mdct_aos_master_f19' }
node 'mdct-aos-master-f20.dartcontainer.com'    { include 'dart::mdct_aos_master_f20' }
node 'mdct-ci-agent1.dartcontainer.com'         { include 'dart::mdct_ci_agent1' }
node 'mdct-dev10.dartcontainer.com'             { include 'dart::mdct_dev10' }
node 'mdct-dev11.dartcontainer.com'             { include 'dart::mdct_dev11' }
node 'mdct-dev12.dartcontainer.com'             { include 'dart::mdct_dev12' }
node 'mdct-dev16.dartcontainer.com'             { include 'dart::mdct_dev16' }
node 'mdct-dev17.dartcontainer.com'             { include 'dart::mdct_dev17' }
node 'mdct-dev18.dartcontainer.com'             { include 'dart::mdct_dev18' }
node 'mdct-dev19.dartcontainer.com'             { include 'dart::mdct_dev19' }
node 'mdct-dev20.dartcontainer.com'             { include 'dart::mdct_dev20' }
node 'mdct-dev21.dartcontainer.com'             { include 'dart::mdct_dev21' }
node 'mdct-dev6-test.dartcontainer.com'         { include 'dart::mdct_dev6_test' }
node 'mdct-dev6.dartcontainer.com'              { include 'dart::mdct_dev6' }
node 'mdct-dev7.dartcontainer.com'              { include 'dart::mdct_dev7' }
node 'mdct-dev9.dartcontainer.com'              { include 'dart::mdct_dev9' }
node 'mdct-dr-dev.dartcontainer.com'            { include 'dart::mdct_dr_dev' }
node 'mdct-dr.dartcontainer.com'                { include 'dart::mdct_dr' }
node 'mdct-est-ci.dartcontainer.com'            { include 'dart::mdct_est_ci' }
node 'mdct-est-dev1.dartcontainer.com'          { include 'dart::mdct_est_dev1' }
node 'mdct-est-dev2.dartcontainer.com'          { include 'dart::mdct_est_dev2' }
node 'mdct-f14-builder.dartcontainer.com'       { include 'dart::mdct_f14_builder' }
node 'mdct-f15-builder.dartcontainer.com'       { include 'dart::mdct_f15_builder' }
node 'mdct-f16-builder.dartcontainer.com'       { include 'dart::mdct_f16_builder' }
node 'mdct-f17-builder.dartcontainer.com'       { include 'dart::mdct_f17_builder' }
node 'mdct-fogbugz.dartcontainer.com'           { include 'dart::mdct_fogbugz' }
node 'mdct-koji.dartcontainer.com'              { include 'dart::mdct_koji' }
node 'mdct-nexus.dartcontainer.com'             { include 'dart::mdct_nexus' }
node 'mdct-ngic-dev.dartcontainer.com'          { include 'dart::mdct_ngic_dev' }
node 'mdct-ngic.dartcontainer.com'              { include 'dart::mdct_ngic' }
node 'mdct-ovirt-engine.dartcontainer.com'      { include 'dart::mdct_ovirt_engine' }
node 'mdct-pt-dbtest.dartcontainer.com'         { include 'dart::mdct_pt_dbtest' }
node 'mdct-recov.dartcontainer.com'             { include 'dart::mdct_recov' }
node 'mdct-tc.dartcontainer.com'                { include 'dart::mdct_tc' }
node 'mdct-teamcity-f20.dartcontainer.com'      { include 'dart::mdct_teamcity_f20' }
node 'mdct-test-agent-32.dartcontainer.com'     { include 'dart::mdct_test_agent_32' }
node 'mole-dev.dartcontainer.com'               { include 'dart::mole_dev' }
node 'mole.dartcontainer.com'                   { include 'dart::mole' }
node 'tc-util.dartcontainer.com'                { include 'dart::tc_util' }


#
# This section consists only of loose host(s):class relations on a M:1 basis.
#
node /^mdct-dev10-.*\.dartcontainer\.com$/      { include 'dart::mdct_dev10_srvr' }
node /^mdct-ovirt-node-.*\.dartcontainer\.com$/ { include 'dart::mdct_ovirt_node' }
node /^mdct-puppet.*\.dartcontainer\.com$/      { include 'dart::mdct_puppet' }
node /^mdct-teamcity-agent.*\.dartcontainer.com$/   { include 'dart::mdct_teamcity_agent' }
node /^mdct-\d+ut\.dartcontainer\.com$/         { include 'dart::mdct_ut' }

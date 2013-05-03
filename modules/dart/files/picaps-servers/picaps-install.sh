#!/bin/bash

# CVS checkout components and deploy
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/bin
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/config
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/static
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/resource
/bin/mkdir -p picaps/reporttemplates
/bin/chmod +x picaps/resource/init.d/picaps
/bin/chmod +x picaps/bin/startup-core.sh
/bin/chmod +x picaps/bin/shutdown-core.sh
/bin/chmod +x picaps/bin/startup-persister.sh
/bin/chmod +x picaps/bin/startup-display.sh
/bin/chmod +x picaps/bin/shutdown-display.sh
/bin/chmod +x picaps/bin/startup-poller.sh
/bin/chmod +x picaps/bin/shutdown-poller.sh
/bin/chmod +x picaps/bin/startup-coretocore.sh
/bin/chmod +x picaps/bin/shutdown-coretocore.sh
/bin/mv /root/picaps /dist

# Integrate with Fedora
/bin/ln -s /dist/resource/init.d/picaps /etc/init.d/picaps
/bin/ln -s /dist/resource/init.d/sysconfig /etc/sysconfig/picaps

# Additional software -- HB->PICAPS Bridge
/bin/wget -P /home/ --no-verbose --mirror --no-host-directories --cut-dirs 3 ftp://mdct-00fs.dartcontainer.com/pub/kickstart/picaps/hbgw
/bin/find /home/hbgw -type f -exec rm -f {}/.listing \;

# Configure PICAPS database
/usr/bin/mysql < /root/picaps-databases.sql
/usr/bin/mysql < /root/picaps-grant.sql


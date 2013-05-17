#!/bin/bash

# CVS checkout components and deploy
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/bin
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/config
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/static
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/resource
/bin/mkdir -p picaps/reporttemplates
# make original startup/shutdown scripts executable
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
/bin/chmod +x picaps/bin/picaps-cvs-update.sh
/bin/chmod +x picaps/bin/optimize-tables.sh
# make systemd startup/shutdown scripts executable
/bin/chmod +x picaps/bin/startup-shutdown/prepare.sh
/bin/chmod +x picaps/bin/startup-shutdown/startup-core.sh
/bin/chmod +x picaps/bin/startup-shutdown/shutdown-core.sh
/bin/chmod +x picaps/bin/startup-shutdown/startup-persister.sh
/bin/chmod +x picaps/bin/startup-shutdown/startup-display.sh
/bin/chmod +x picaps/bin/startup-shutdown/shutdown-display.sh
/bin/chmod +x picaps/bin/startup-shutdown/startup-poller.sh
/bin/chmod +x picaps/bin/startup-shutdown/shutdown-poller.sh
/bin/chmod +x picaps/bin/startup-shutdown/startup-coretocore.sh
/bin/chmod +x picaps/bin/startup-shutdown/shutdown-coretocore.sh

/bin/mv /root/picaps /dist

# Integrate with Fedora
# older versions without systemd
  #/bin/ln -s /dist/resource/init.d/picaps /etc/init.d/picaps
  #/bin/ln -s /dist/resource/init.d/sysconfig /etc/sysconfig/picaps
# configuration files
/bin/ln -s /dist/config/picaps /etc/sysconfig/picaps
/bin/ln -s /dist/config/picaps-bridge /etc/sysconfig/picaps-bridge
/bin/ln -s /dist/config/picaps-core /etc/sysconfig/picaps-core
/bin/ln -s /dist/config/picaps-coretocore /etc/sysconfig/picaps-coretocore
/bin/ln -s /dist/config/picaps-display /etc/sysconfig/picaps-display
/bin/ln -s /dist/config/picaps-persister /etc/sysconfig/picaps-persister
/bin/ln -s /dist/config/picaps-poller /etc/sysconfig/picaps-poller
# systemd target & services
/bin/cp -a /dist/resource/systemd/picaps-all.target /etc/systemd/system/picaps-all.target
/bin/cp -a /dist/resource/systemd/picaps-bridge.service /etc/systemd/system/picaps-bridge.service
/bin/cp -a /dist/resource/systemd/picaps-core.service /etc/systemd/system/picaps-core.service
/bin/cp -a /dist/resource/systemd/picaps-coretocore.service /etc/systemd/system/picaps-coretocore.service
/bin/cp -a /dist/resource/systemd/picaps-display.service /etc/systemd/system/picaps-display.service
/bin/cp -a /dist/resource/systemd/picaps-persister.service /etc/systemd/system/picaps-persister.service
/bin/cp -a /dist/resource/systemd/picaps-poller.service /etc/systemd/system/picaps-poller.service
/bin/systemctl --system daemon-reload
# enable services
#/bin/systemctl enable picaps-bridge.service
/bin/systemctl enable picaps-core.service
#/bin/systemctl enable picaps-coretocore.service
/bin/systemctl enable picaps-display.service
/bin/systemctl enable picaps-persister.service
#/bin/systemctl enable picaps-poller.service

# Additional software -- HB->PICAPS Bridge
/bin/wget -P /home/ --no-verbose --mirror --no-host-directories --cut-dirs 3 ftp://mdct-00fs.dartcontainer.com/pub/kickstart/picaps/hbgw
/bin/find /home/hbgw -type f -exec rm -f {}/.listing \;

# Configure PICAPS database
/usr/bin/mysql < /root/picaps-databases.sql
/usr/bin/mysql < /root/picaps-grant.sql

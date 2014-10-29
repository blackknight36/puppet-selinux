#!/bin/bash

# CVS checkout components and deploy
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/bin
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/config
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/static
/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/resource
  #/bin/cvs -d :pserver:anonymous@10.1.192.105:/home/cvsroot co picaps/reporttemplates # corporate only
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
/bin/chmod +x picaps/bin/startup-shutdown/shutdown-core.sh
/bin/chmod +x picaps/bin/startup-shutdown/shutdown-display.sh
/bin/chmod +x picaps/bin/startup-shutdown/shutdown-coretocore.sh
  #/bin/chmod +x picaps/bin/corporate/sap-file-watcher.sh # corporate only
  #/bin/chmod +x picaps/bin/corporate/export-sap-pm-measurements.sh #corporate only
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
/bin/ln -s /dist/config/picaps-replication /etc/sysconfig/picaps-replication
# corporate only
  #/bin/ln -sd /dist/resource/cron/sap-file-watcher /etc/cron.d/sap-file-watcher
  #/bin/ln -sd /dist/resource/cron/export-sap-pm-measurements /etc/cron.d/export-sap-pm-measurements
# systemd target & services
/bin/cp -a /dist/resource/systemd/picaps-all.target /etc/systemd/system/picaps-all.target
/bin/cp -a /dist/resource/systemd/picaps-bridge-1.service /etc/systemd/system/picaps-bridge-1.service
/bin/cp -a /dist/resource/systemd/picaps-bridge-2.service /etc/systemd/system/picaps-bridge-2.service
/bin/cp -a /dist/resource/systemd/picaps-core.service /etc/systemd/system/picaps-core.service
/bin/cp -a /dist/resource/systemd/picaps-coretocore.service /etc/systemd/system/picaps-coretocore.service
/bin/cp -a /dist/resource/systemd/picaps-display.service /etc/systemd/system/picaps-display.service
/bin/cp -a /dist/resource/systemd/picaps-persister.service /etc/systemd/system/picaps-persister.service
/bin/cp -a /dist/resource/systemd/picaps-poller.service /etc/systemd/system/picaps-poller.service
/bin/cp -a /dist/resource/systemd/picaps-replication.service /etc/systemd/system/picaps-replication.service
/bin/systemctl --system daemon-reload
# disable services
/bin/systemctl disable picaps-core.service
/bin/systemctl disable picaps-display.service
/bin/systemctl disable picaps-persister.service
/bin/systemctl disable picaps-poller.service
/bin/systemctl disable picaps-bridge-1.service
/bin/systemctl disable picaps-bridge-2.service
/bin/systemctl disable picaps-coretocore.service
/bin/systemctl disable picaps-all.target

# Configure PICAPS database
/usr/bin/mysql < /root/picaps-databases.sql
/usr/bin/mysql < /root/picaps-grant.sql

#!/bin/bash

lpadmin -E -p TESTCK -v http://mdct-dev6:631/printers/TESTCK -o printer-error-policy=abort-job -m raw
lpadmin -E -p TESTJF -v http://mdct-dev12:631/printers/TESTJF -o printer-error-policy=abort-job -m raw
lpadmin -E -p TESTCP -v http://10.1.250.45:631/printers/TESTCP -o printer-error-policy=abort-job -m raw
lpadmin -E -p TESTAH -v http://mdct-dev14:631/printers/TESTAH -o printer-error-policy=abort-job -m raw
lpadmin -E -p TESTRB -v http://10.1.250.50:631/printers/TESTRB -o printer-error-policy=abort-job -m raw
lpadmin -E -p TESTCR -v http://mdct-dev7:631/printers/TESTCR -o printer-error-policy=abort-job -m raw
lpadmin -E -p TESTNN -v http://mdct-dev9:631/printers/TESTNN -o printer-error-policy=abort-job -m raw
lpadmin -E -p TESTBE -v http://10.1.192.121:631/printers/TESTBE -o printer-error-policy=abort-job -m raw

lpstat -a | awk '/TESTCK\ |JF\ |CP\ |AH\ |RB\ |CR\ |NN\ |BE\ /{print $1}' | xargs cupsenable
lpstat -a | awk '/TESTCK\ |JF\ |CP\ |AH\ |RB\ |CR\ |NN\ |BE\ /{print $1}' | xargs accept

 # 00 - Corporate / MDC
  /usr/sbin/lpadmin -p LP00051 -E -v socket://10.1.0.147 -m laserjet.ppd.gz
  /usr/sbin/lpadmin -p LP00052 -E -v socket://10.1.0.164 -m epson9.ppd.gz
  /usr/sbin/lpadmin -p LP00053 -E -v socket://10.1.0.166 -m epson9.ppd.gz
  /usr/sbin/lpadmin -p LP00054 -E -v socket://10.1.0.169 -m epson9.ppd.gz
  /usr/sbin/lpadmin -p LP00055 -E -v socket://10.1.80.7 -m epson9.ppd.gz
  /usr/sbin/lpadmin -p LP00056 -E -v socket://10.1.250.162:9900

  # 01 - Mason
  /usr/sbin/lpadmin -p LP01011 -E -v socket://10.1.193.1:9900
  /usr/sbin/lpadmin -p LP01012 -E -v socket://10.1.193.2:9900
  /usr/sbin/lpadmin -p LP01013 -E -v socket://10.1.193.3:9900

  # 02 - Leola
  /usr/sbin/lpadmin -p LP02011 -E -v socket://10.2.193.2:9900
  /usr/sbin/lpadmin -p LP02012 -E -v socket://10.2.193.3:9900
  /usr/sbin/lpadmin -p LP02013 -E -v socket://10.2.193.16:9900
  /usr/sbin/lpadmin -p LP02014 -E -v socket://10.2.193.4:9900
  /usr/sbin/lpadmin -p LP02015 -E -v socket://10.2.193.8:9900
  /usr/sbin/lpadmin -p LP02016 -E -v socket://10.2.193.9:9900
  /usr/sbin/lpadmin -p LP02017 -E -v socket://10.2.0.53:9900
  /usr/sbin/lpadmin -p LP02018 -E -v socket://10.2.193.14:9900
  /usr/sbin/lpadmin -p LP02019 -E -v socket://10.2.193.15:9900
  /usr/sbin/lpadmin -p LP0201A -E -v socket://10.2.193.18:9900
  /usr/sbin/lpadmin -p LP0201B -E -v socket://10.2.193.19:9900
  /usr/sbin/lpadmin -p LP02041 -E -v socket://10.2.193.11:9900
  /usr/sbin/lpadmin -p LP02051 -E -v socket://10.2.193.5:9900
  /usr/sbin/lpadmin -p LP02061 -E -v socket://10.2.193.10:9900
  /usr/sbin/lpadmin -p LP02062 -E -v socket://10.2.193.6:9900
  /usr/sbin/lpadmin -p LP02063 -E -v socket://10.2.193.7:9900
  /usr/sbin/lpadmin -p LP02064 -E -v socket://10.2.193.13:9900
  /usr/sbin/lpadmin -p LP02081 -E -v socket://10.2.0.52:9900
  /usr/sbin/lpadmin -p LP02121 -E -v socket://10.2.193.1:9900
  /usr/sbin/lpadmin -p LP02131 -E -v socket://10.2.193.12:9900

  # 03 - Lithonia
  /usr/sbin/lpadmin -p LP03011 -E -v socket://10.3.193.1:9900
  /usr/sbin/lpadmin -p LP03012 -E -v socket://10.3.193.2:9900
  /usr/sbin/lpadmin -p LP03013 -E -v socket://10.3.193.3:9900
  /usr/sbin/lpadmin -p LP03014 -E -v socket://10.3.193.4:9900

  # 04 - Aurora
  /usr/sbin/lpadmin -p LP04011 -E -v socket://10.4.193.1:9900
  /usr/sbin/lpadmin -p LP04012 -E -v socket://10.4.193.2:9900
  /usr/sbin/lpadmin -p LP04013 -E -v socket://10.4.193.3:9900
  /usr/sbin/lpadmin -p LP04014 -E -v socket://10.4.193.4:9900
  /usr/sbin/lpadmin -p LP04015 -E -v socket://10.4.193.5:9900
  /usr/sbin/lpadmin -p LP04016 -E -v socket://10.4.193.6:9900
  /usr/sbin/lpadmin -p LP04017 -E -v socket://10.4.193.7:9900
  /usr/sbin/lpadmin -p LP0401BPRN -E -v socket://10.4.193.30:9900

  # 05 - Corona
  /usr/sbin/lpadmin -p LP05011 -E -v socket://10.5.193.1:9900
  /usr/sbin/lpadmin -p LP05012 -E -v socket://10.5.193.2:9900
  /usr/sbin/lpadmin -p LP05013 -E -v socket://10.5.193.3:9900
  /usr/sbin/lpadmin -p LP05031 -E -v socket://10.5.193.4:9900
  /usr/sbin/lpadmin -p LP05032 -E -v socket://10.5.193.5:9900
  /usr/sbin/lpadmin -p LP0501BPRN -E -v socket://10.5.193.30:9900

  # 10 - Waxahachie
  /usr/sbin/lpadmin -p LP10011 -E -v socket://10.10.193.1:9900
  /usr/sbin/lpadmin -p LP10012 -E -v socket://10.10.193.2:9900
  /usr/sbin/lpadmin -p LP10013 -E -v socket://10.10.193.3:9900
  /usr/sbin/lpadmin -p LP10014 -E -v socket://10.10.193.4:9900
  /usr/sbin/lpadmin -p LP10015 -E -v socket://10.10.193.5:9900
  /usr/sbin/lpadmin -p LP10016 -E -v socket://10.10.193.6:9900
  /usr/sbin/lpadmin -p LP10017 -E -v socket://10.10.193.7:9900
  /usr/sbin/lpadmin -p LP10018 -E -v socket://10.10.193.8:9900
  /usr/sbin/lpadmin -p LP10019 -E -v socket://10.10.193.9:9900
  /usr/sbin/lpadmin -p LP1000A -E -v socket://10.10.193.10:9900
  /usr/sbin/lpadmin -p LP1001BPRN -E -v socket://10.10.193.30:9900

  # 11 - HorseCave
  /usr/sbin/lpadmin -p LP11011 -E -v socket://10.11.193.1:9900
  /usr/sbin/lpadmin -p LP11012 -E -v socket://10.11.193.3:9900
  /usr/sbin/lpadmin -p LP11013 -E -v socket://10.11.193.4:9900
  /usr/sbin/lpadmin -p LP11031 -E -v socket://10.11.193.2:9900
  /usr/sbin/lpadmin -p LP11014 -E -v socket://10.11.193.5:9900

  # 15 - Quitman
  /usr/sbin/lpadmin -p LP15011 -E -v socket://10.15.193.1:9900
  /usr/sbin/lpadmin -p LP15012 -E -v socket://10.15.193.2:9900

  # 19 - Plant City, FL
  /usr/sbin/lpadmin -p LP19011 -E -v socket://10.19.193.1:9900
  /usr/sbin/lpadmin -p LP19012 -E -v socket://10.19.193.2:9900
  /usr/sbin/lpadmin -p LP19013 -E -v socket://10.19.193.3:9900
  /usr/sbin/lpadmin -p LP19014 -E -v socket://10.19.193.4:9900
  /usr/sbin/lpadmin -p LP1901BPRN -E -v socket://10.19.193.30:9900

  # 25 - Tumwater
  /usr/sbin/lpadmin -p LP25011 -E -v socket://10.25.193.3:9900 -o printer-error-policy=abort-job -o printer-is-shared=0
  /usr/sbin/lpadmin -p LP25012 -E -v socket://10.25.193.2:9900 -o printer-error-policy=abort-job -o printer-is-shared=0
  /usr/sbin/lpadmin -p LP25013 -E -v socket://10.25.193.4:9900 -o printer-error-policy=abort-job -o printer-is-shared=0
  /usr/sbin/lpadmin -p LP2501BPRN -E -v socket://10.25.193.30:9900

  # 39 - Randleman
  /usr/sbin/lpadmin -p LP39011 -E -v socket://10.39.193.1:9900

  # 52 - Lancaster
  /usr/sbin/lpadmin -p LP52011 -E -v socket://10.52.193.1:9900

  # 72 - Tijuana
  /usr/sbin/lpadmin -p LP72011 -E -v socket://10.72.193.1:9900
  /usr/sbin/lpadmin -p LP72012 -E -v socket://10.72.193.2:9900
  /usr/sbin/lpadmin -p LP72013 -E -v socket://10.72.193.3:9900
  /usr/sbin/lpadmin -p LP72014 -E -v socket://10.72.193.4:9900
  /usr/sbin/lpadmin -p LP72015 -E -v socket://10.72.193.5:9900
  /usr/sbin/lpadmin -p LP7201BPRN -E -v socket://10.72.193.30:9900

  # 75 - England
  /usr/sbin/lpadmin -p LP75011 -E -v socket://10.75.193.1:9900
  /usr/sbin/lpadmin -p LP75012 -E -v socket://10.75.193.2:9900
  /usr/sbin/lpadmin -p LP75013 -E -v socket://10.75.193.3:9900
  /usr/sbin/lpadmin -p LP75014 -E -v socket://10.75.193.4:9900
  /usr/sbin/lpadmin -p LP75015 -E -v socket://10.75.193.5:9900
  /usr/sbin/lpadmin -p LP7501BPRN -E -v socket://10.75.193.30:9900

  # 76 - Australia
  /usr/sbin/lpadmin -p LP76011 -E -v socket://10.76.193.1:9900
  /usr/sbin/lpadmin -p LP76012 -E -v socket://10.76.193.2:9900

  # 77 - Canada
  /usr/sbin/lpadmin -p LP77011 -E -v socket://10.77.193.2:9900
  /usr/sbin/lpadmin -p LP7701BPRN -E -v socket://10.77.193.30:9900

  # 78 - Mexico
  /usr/sbin/lpadmin -p LP78011 -E -v socket://10.78.193.1:9900
  /usr/sbin/lpadmin -p LP78012 -E -v socket://10.78.193.2:9900


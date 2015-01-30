#!/usr/bin/python
# Responsible for determining if PICAPS Echo site is up, if not redirect to
# a message explaining it is down for maintenance.
import telnetlib
import traceback
import sys
from cgi import *

HOST="<%= @fqdn %>"
PORT="443"

print 'Content-type: text/html'
print 

form = FormContent()
if form.has_key("host"):
   HOST=form["host"][0]

if form.has_key("port"):
   PORT=form["port"][0]

try:
   tn = telnetlib.Telnet(HOST, PORT)
   tn.close()
   # we are good to go send to PICAPS Echo site
   print '<META HTTP-EQUIV="refresh" content="0;url=https://%s:%s/Echo">' % (HOST, PORT)
except:
   # display down site message
   print """<META HTTP-EQUIV="refresh" content="30;">
            <HTML>
            <BODY BGCOLOR=WHITE LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
            <TABLE bgcolor=white height="100%" width="100%" border=0>
            <TR><TD BGCOLOR=RED HEIGHT="10%"><DIV ALIGN=LEFT><img border="0"; src="../icons/picaps-logo.gif"/></DIV></TD></TR>
            <TR><TD><DIV ALIGN=CENTER><FONT SIZE=+2>System down due to PICAPS system maintenance and/or enhancements.</FONT></DIV></TD></TR>
            </TABLE>
            </BODY>
            </HTML>"""

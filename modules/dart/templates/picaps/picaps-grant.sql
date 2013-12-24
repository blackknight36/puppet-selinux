use mysql;
delete from user where user = 'lh5717';
grant all on picap.* to lh5717 identified by "test";
grant all on picap.* to lh5717@'%' identified by "test";
grant all on picap.* to lh5717@'127.0.0.1' identified by "test";
grant all on picap.* to lh5717@'localhost' identified by "test";
grant all on picap.* to lh5717@'<%= @ipaddress %>' identified by "test";
grant all on picap.* to lh5717@'<%= @hostname %>' identified by "test";
grant all on picap.* to lh5717@'<%= @fqdn %>' identified by "test";
grant all on picaptest.* to lh5717 identified by "test";
grant all on picaptest.* to lh5717@'%' identified by "test";
grant all on picaptest.* to lh5717@'127.0.0.1' identified by "test";
grant all on picaptest.* to lh5717@'localhost' identified by "test";
grant all on picaptest.* to lh5717@'<%= @ipaddress %>' identified by "test";
grant all on picaptest.* to lh5717@'<%= @hostname %>' identified by "test";
grant all on picaptest.* to lh5717@'<%= @fqdn %>' identified by "test";
grant all on picapsmetrics.* to lh5717 identified by "test";
grant all on picapsmetrics.* to lh5717@'%' identified by "test";
grant all on picapsmetrics.* to lh5717@'127.0.0.1' identified by "test";
grant all on picapsmetrics.* to lh5717@'localhost' identified by "test";
grant all on picapsmetrics.* to lh5717@'<%= @ipaddress %>' identified by "test";
grant all on picapsmetrics.* to lh5717@'<%= @hostname %>' identified by "test";
grant all on picapsmetrics.* to lh5717@'<%= @fqdn %>' identified by "test";
exit


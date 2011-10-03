# Synopsis:
#       Determine the plant number by parsing out the 2nd octet of the host's
#       default route.  The value returned will be a two digit code,
#       left-padded with zeroes, e.g., (Mason ==> "01").  If no default route
#       exists, nil will be returned.
#
# NB: This custom fact requires that the pluginsync feature be enabled in
# puppet.conf.

Facter.add("plant_number") do
    # Currently, with puppet-2.6.6-1.fc15.noarch and
    # facter-1.6.0-2.fc15.noarch, this causes a zombie process every time
    # puppet applies the catalog on the client.  Zombies will accumulate until
    # puppetd is restarted.  See http://projects.puppetlabs.com/issues/8239
    # for more details.  Kludging by assuming Mason everywhere.
    #
    #   begin
    #       gw = IO.popen("/sbin/ip route show 0.0.0.0/0").read().split()[2]
    #       if gw
    #           plant = "%02d" % gw.split(".")[1]
    #       else
    #           plant = nil
    #       end
    #   end
    plant = '01'
    setcode do
        plant
    end
end

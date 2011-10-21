# modules/dart/files/facter/plant_number.rb
#
# Synopsis:
#       Determine the plant number by parsing out the 2nd octet of the host's
#       default route.  The value returned will be a two digit code,
#       left-padded with zeroes, e.g., (Mason ==> "01").  If no default route
#       exists, nil will be returned.

Facter.add("plant_number") do
    begin
        gw = IO.popen("/sbin/ip route show 0.0.0.0/0").read().split()[2]
        if gw
            plant = "%02d" % gw.split(".")[1]
        else
            plant = nil
        end
    end
    setcode do
        plant
    end
end

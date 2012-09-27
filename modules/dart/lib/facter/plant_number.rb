# modules/dart/files/facter/plant_number.rb
#
# Synopsis:
#       Determine the plant number by parsing out the 2nd octet of the host's
#       default route.  The value returned will be a two digit code,
#       left-padded with zeroes, e.g., (Mason ==> "01").  If no default route
#       exists, nil will be returned.

Facter.add("plant_number") do
    begin
        output = %x{/sbin/ip route show 0.0.0.0/0}
        gw = output.split()[2]
        if gw
            subnet = "%02d" % gw.split(".")[1]
        else
            subnet = nil
        end
    end
    setcode do
        case subnet
        when '06'
            # Aurora, IL is an exception.  Originally subnetted as 10.4/16,
            # they've migrated to 10.6/16 to accommodate integration of the
            # Solo network, yet remain plant# 04.
            '04'
        else
            subnet
        end
    end
end

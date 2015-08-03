# lib/ruby/facter/plant_number.rb
#
# Synopsis:
#       A facter fact providing the Dart plant number where this host resides.
#
# Description:
#       Host residence is determined by examination of the host's default IP
#       route address.  This avoids issues with hosts that may have multiple
#       network connections, interface names, etc.  The default IP route
#       address can then be mapped to one many known subnets, each having an
#       associated plant number.
#
#       The value returned will be a two-digit code, left-padded with zeroes,
#       (e.g., a node in Mason yields "01") unless two digits is insufficient
#       in which case the value returned will be a four-digit code, (e.g.,
#       a node in Dallas yields "0314").  If the plant number cannot be
#       determined with certainty, a value of "unknown" will be returned.
#
# Author: John Florian <john_florian@dart.biz>
# Copyright 2011-2015 Dart Container Corp.


Facter.add("plant_number") do
    require 'ipaddr'

    # Define a simple data structure to represent a Dart production facility
    # and the subnets used there.
    Plant = Struct.new(:id, :subnets) unless defined?(Plant)

    def plant_with_ipaddr(ipaddr)
        plants = [
            Plant.new('01', [
                IPAddr.new('10.1.0.0/16'),
                IPAddr.new('10.208.0.0/14'),
            ]),
            Plant.new('02', [
                IPAddr.new('10.2.0.0/16'),
            ]),
            Plant.new('03', [
                IPAddr.new('10.3.0.0/16'),
            ]),
            Plant.new('04', [
                IPAddr.new('10.6.0.0/16'),
            ]),
            Plant.new('05', [
                IPAddr.new('10.5.0.0/16'),
                IPAddr.new('10.202.134.0/23'),
            ]),
            Plant.new('10', [
                IPAddr.new('10.10.0.0/16'),
                IPAddr.new('10.110.4.0/22'),
            ]),
            Plant.new('11', [
                IPAddr.new('10.11.0.0/16'),
            ]),
            Plant.new('15', [
                IPAddr.new('10.15.0.0/16'),
            ]),
            Plant.new('19', [
                IPAddr.new('10.19.0.0/16'),
            ]),
            Plant.new('25', [
                IPAddr.new('10.25.0.0/16'),
            ]),
            Plant.new('39', [
                IPAddr.new('10.39.0.0/16'),
            ]),
            Plant.new('47', [
                IPAddr.new('10.47.0.0/16'),
            ]),
            Plant.new('52', [
                IPAddr.new('10.52.0.0/16'),
            ]),
            Plant.new('55', [
                IPAddr.new('10.55.0.0/16'),
            ]),
            Plant.new('72', [
                IPAddr.new('10.72.0.0/16'),
            ]),
            Plant.new('73', [
                IPAddr.new('10.73.0.0/16'),
            ]),
            Plant.new('75', [
                IPAddr.new('10.75.0.0/16'),
            ]),
            Plant.new('76', [
                IPAddr.new('10.76.0.0/16'),
            ]),
            Plant.new('77', [
                IPAddr.new('10.77.0.0/16'),
            ]),
            Plant.new('78', [
                IPAddr.new('10.78.0.0/16'),
            ]),
            Plant.new('96', [
                IPAddr.new('10.96.0.0/16'),
            ]),
            Plant.new('0302', [
                IPAddr.new('10.7.84.0/22'),
            ]),
            Plant.new('0310', [
                IPAddr.new('10.31.52.0/22'),
            ]),
            Plant.new('0314', [
                IPAddr.new('10.7.212.0/22'),
            ]),
        ]

        plants.each { |plant|
            plant.subnets.each { |subnet|
                if subnet.include?(ipaddr)
                    return plant.id
                end
            }
        }
        return 'unknown'
    end

    setcode do
        # The gateway address is used here because it's so easy to get/parse.
        gw = IPAddr.new(%x{/sbin/ip route show 0.0.0.0/0}.split()[2])
        plant_with_ipaddr(gw)
    end
end

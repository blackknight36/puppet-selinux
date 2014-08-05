# modules/dart/lib/facter/default_route.rb
#
# Synopsis:
#       Expose the host's default route as a fact.
#
#       At Dart this is likely the sanest way to determine plant-specific
#       attributes in an completely automated manner.
#
# Author: John Florian <john_florian@dart.biz>
# Copyright 2014 Dart Container Corp.


Facter.add('default_route') do
    begin
        output = %x{/sbin/ip route show 0.0.0.0/0}
        gw = output.split()[2]
    end
    setcode do
        gw
    end
end

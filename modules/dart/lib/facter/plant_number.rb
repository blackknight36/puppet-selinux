# modules/dart/lib/facter/plant_number.rb
#
# Synopsis:
#       Determine the plant number by mapping known default routes for each
#       plant entity.  The value returned will be a two digit code,
#       left-padded with zeroes, e.g., (Mason ==> "01") unless two digits is
#       insufficient in which case the value returned will be a four digit
#       code, e.g., (Dallas ==> "0314").  If no default route exists, nil will
#       be returned.
#
# Author: John Florian <john_florian@dart.biz>
# Copyright 2011-2014 Dart Container Corp.


Facter.add("plant_number") do
    begin
        output = %x{/sbin/ip route show 0.0.0.0/0}
        gw = output.split()[2]
        gw_to_plant_map = {
            '10.1.0.25'     => '01',
            '10.2.0.25'     => '02',
            '10.3.0.25'     => '03',
            '10.6.0.25'     => '04',
            '10.5.0.25'     => '05',
            '10.10.0.25'    => '10',
            '10.11.0.25'    => '11',
            '10.15.0.25'    => '15',
            '10.19.0.25'    => '19',
            '10.25.0.25'    => '25',
            '10.39.0.25'    => '39',
            '10.47.0.25'    => '47',
            '10.52.0.25'    => '52',
            '10.55.0.25'    => '55',
            '10.72.0.25'    => '72',
            '10.73.0.25'    => '73',
            '10.75.0.25'    => '75',
            '10.76.0.25'    => '76',
            '10.77.0.25'    => '77',
            '10.78.0.25'    => '78',
            '10.96.0.25'    => '96',
            '10.7.87.254'   => '0302',
            '10.31.55.254'  => '0310',
            '10.7.215.254'  => '0314',
        }
    end
    setcode do
        gw_to_plant_map[gw] or nil
    end
end

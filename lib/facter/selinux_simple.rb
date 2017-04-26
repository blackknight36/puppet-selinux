# modules/selinux/lib/facter/selinux_simple.rb
#
# Synopsis:
#       Facter's own selinux fact is encumbered with unnecessary complexity
#       and has been found to emit the wrong value in a number of cases.  This
#       alternate, simple implementation works more reliably, at least for our
#       use cases with Fedora Linux.

Facter.add('selinux_simple') do
    confine :kernel => :linux
    setcode do
        case Facter.value('osfamily')
            when 'RedHat'
                mode = Facter::Util::Resolution.exec('/usr/sbin/getenforce').chomp
                if mode.casecmp('Enforcing') == 0
                    result = true
                else
                    result = false
                end
            else
                result = false
        end
        result
    end
end

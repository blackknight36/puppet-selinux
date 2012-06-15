# modules/selinux/lib/facter/selinux_simple.rb
#
# Synopsis:
#       Facter's own selinux fact is encumbered with unnecessary complexity
#       and has been found to emit the wrong value in a number of cases.  This
#       alternate, simple implementation works more reliably, at least for our
#       use cases with Fedora Linux.

getenforce_cmd = '/usr/sbin/getenforce'

Facter.add("selinux_simple") do
    setcode do
        mode = Facter::Util::Resolution.exec(getenforce_cmd)
        if mode.casecmp('enforcing') == 0
            result = "true"
        else
            result = "false"
        end
        result
    end
end

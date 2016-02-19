# modules/ovirt/lib/facter/is_ovirt_guest.rb
#
# Synopsis:
#       Facter's own virutal fact is encumbered with unnecessary complexity
#       and has been found to emit the wrong value in a some cases.  Consider
#       the following example on the puppet master:
#
#           $ facter virtual
#           ovirt
#           $ sudo facter virtual
#           kvm
#
#       The first result is the more correct.  The second changes because, once
#       root authority is available, facter can run virt-what which provides
#       the kvm output.  This is true as of facter-1.7.4-1.fc20.x86_64.  Even
#       if this does get resolved upstream, this module-provided fact gives us
#       reliable operation for older Fedoras.  Versions prior to 1.7 were
#       completely lacking the required support.
#
#       This alternate, simple implementation works more reliably, at least
#       for our use cases with Fedora Linux.  However, a casual glance should
#       reveal that this DOES NOT tell you what virtualization technology is
#       being used, but rather a simple boolean of whether oVirt is being
#       used.  That's all we need to know in this puppet module.

Facter.add("is_ovirt_guest") do
    setcode do
        File.read("/sys/devices/virtual/dmi/id/product_name") =~ /oVirt Node/ rescue false
    end
end

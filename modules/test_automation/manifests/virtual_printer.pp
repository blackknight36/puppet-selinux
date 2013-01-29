# modules/test_automation/manifests/virtual_printer.pp
#
# Synopsis:
#       Configures CUPS with a virtual printer (i.e., prints to file) for use
#       with the test-automation package.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            instance name, e.g., 'TESTJF'
#       ensure          present         instance is to be present/absent
#
# Requires:
#       Module['cups']  # AKA mosen-cups upstream


define test_automation::virtual_printer ($ensure='present') {

    printer { "${name}":
        description     => 'test-automation target',
        location        => "virtual printer on ${fqdn}",
        model           => 'raw',
        uri             => "http://${fqdn}:631/printers/${name}",
        options         => {
            printer-error-policy        => 'abort-job',
        },
        ensure          => $ensure,
        enabled         => true,
        accept          => true,
        shared          => true,
    }

}

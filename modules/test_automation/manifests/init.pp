# modules/test_automation/manifests/init.pp
#
# Synopsis:
#       Configures a host to use the test-automation package.


class test_automation {

    package { 'test-automation':
        ensure  => installed,
    }

    # Must allow remote systems to contact this host via IPP in order for the
    # Report Diff Viewer to work correctly.
    lokkit::tcp_port {
        'ipp': port => '631',
    }

}

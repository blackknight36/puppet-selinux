# modules/dart/manifests/classes/no-dns-hosts.pp
#
# Synopsis:
#       Host resolution details for hosts not in Dart's DNS records.

class dart::no-dns-hosts {

    host { "mdct-f8-builder.dartcontainer.com":
        ip              => "10.1.192.132",
        host_aliases    => [ "mdct-f8-builder", "f8b" ],
    }

    host { "mdct-f10-builder.dartcontainer.com":
        ip              => "10.1.192.133",
        host_aliases    => [ "mdct-f10-builder", "f10b" ],
    }

    host { "mdct-f11-builder.dartcontainer.com":
        ip              => "10.1.192.135",
        host_aliases    => [ "mdct-f11-builder", "f11b" ],
    }

    host { "mdct-f12-builder.dartcontainer.com":
        ip              => "10.1.192.134",
        host_aliases    => [ "mdct-f12-builder", "f12b" ],
    }

    host { "mdct-f13-builder.dartcontainer.com":
        ip              => "10.1.192.136",
        host_aliases    => [ "mdct-f13-builder", "f13b" ],
    }

    host { "mdct-f14-builder.dartcontainer.com":
        ip              => "10.1.192.137",
        host_aliases    => [ "mdct-f14-builder", "f14b" ],
    }

    host { "mdct-f15-builder.dartcontainer.com":
        ip              => "10.1.192.138",
        host_aliases    => [ "mdct-f15-builder", "f15b" ],
    }

}

# /etc/puppet/modules/lotus_notes_client/manifests/init.pp

class lotus_notes_client {

    $key_store="http://mdct-00fs.dartcontainer.com/ftp/pub/fedora/mdct/signing_keys"

    exec { "import_ibm_signing_key":
        command => "rpm --import $key_store/pub_ibm_lotus_notes.gpg",
        unless  => "rpm -q gpg-pubkey-34f9ae75",
    }

    package { "ibm_lotus_notes":
	ensure	=> installed,
        require => [
            Exec["import_ibm_signing_key"],
        ],
    }

    # mdct-dev12 treated specially.  I manually imported the key (via rpm
    # --import) and then removed it (via rpm -e) to verify this class would
    # work correctly, but the key always fails to import there now.  However,
    # it the key is trusted for installing packages signed with it, hence the
    # selector mess.
    exec { "import_f8_new_signing_key":
        command => "rpm --import $key_store/RPM-GPG-KEY-fedora-8-new",
        unless  => $hostname ? {
            "mdct-dev12"        => "true",
            default             => "rpm -q gpg-pubkey-4f2a6fd2",
        },
    }

    # This package brought forth from Fedora 8.  Notes will run without these
    # fonts, but much of the rendering will be wrong.  Fedora dropped these
    # fonts due to licensing concerns.
    package { "xorg-x11-fonts-truetype-7.2-3.fc8":
	ensure	=> installed,
        require => [
            Exec["import_f8_new_signing_key"],
        ],
    }

}

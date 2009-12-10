# /etc/puppet/modules/mpd/manifests/init.pp

class mpd {

    # TODO: try out jack instead of pulseaudio.  PA doesn't allow various
    # things to share the sound card anyway!

    package { "mpd":
	ensure	=> installed,
    }

    # static file
    file { "/etc/mpd.conf":
        # don't forget to verify these!
        group	=> "mpd",
        mode    => 644,
        owner   => "mpd",
        require => Package["mpd"],
        source  => "puppet:///mpd/mpd.conf",
    }

    user { "mpd":
        ensure          => present,
        # mpd needs access to the audio group so that if it starts its own
        # instance of pulseaudio, its instance will need access to the sound
        # card.
        groups          => ["audio, pulse-access", "pulse", "pulse-rt"],
    }

    service { "mpd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["mpd"],
        ],
        subscribe	=> [
            File["/etc/mpd.conf"],
        ]
    }

}

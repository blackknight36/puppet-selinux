# modules/postgresql/manifests/init.pp
#
# Synopsis:
#       Configures a host as a PostgreSQL client.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE
#
# Example usage:
#
#       include postgresql

class postgresql {

    package { 'postgresql':
        ensure  => installed,
    }

}

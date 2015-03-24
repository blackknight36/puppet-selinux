# modules/koji/manifests/database.pp
#
# == Class: koji::database
#
# Manages the Koji database on a host.
#
# This class presently assumes a PostgreSQL database.  It will handles all
# Koji database set up steps for a PostgreSQL server as described at:
#   https://fedoraproject.org/wiki/Koji/ServerHowTo#PostgreSQL_Server
#
# Specifically, this class will:
#   1. install/configure the PostgreSQL server, including authentication
#   2. create the database and PostgreSQL user role
#   3. import the Koji database schema
#   4. bootstrap the database with an initial Koji administrator account
#
# === Upgrading
#
# This class is primarily useful for establishing new Koji setups.  If you
# already have a Koji setup and you are building a newer one to replace it,
# a suggested procedure is as follows:
#
#   1. successfully apply this to the new Koji host ($NEW)
#   2. stop the Puppet agent on $NEW
#   3. stop the PostgreSQL server on $NEW
#   4. reinitialize the database cluster
#   5. perform a full dump on the old Koji host $(OLD)
#   6. transfer the dumped content to $NEW
#   7. load the dumped content on $NEW
#   8. review migration documents on $NEW; see "rpm -qd koji"
#
# === Parameters
#
# ==== Required
#
# [*password*]
#   Password for the created database user.
#
# [*schema_source*]
#   Source URI for the Koji database schema.  Typically, this is available in
#   /usr/share/doc/koji*/docs/schema.sql on Fedora.
#
# ==== Optional
#
# [*dbname*]
#   Name of the database.  Defaults to "koji".
#
# [*username*]
#   Name of the user who is to own the database.  Defaults to "koji".
#
# [*web_username*]
#   Name of the that runs the Koji-Web server.  Defaults to "apache".
#
# [*listen_addresses*]
#   From where should the PostgreSQL server accept connections?  Defaults to
#   "localhost" which means it will only accept connections originating from
#   the local host.  A value of "*" makes the PostgreSQL server accept
#   connections from any remote host.  You may instead choose to specify
#   a comma-separated list of host names and/or IP addresses.
#
#   NB: This parameter affects the entire PostgreSQL server, not just the Koji
#   database.  If the database cluster has other duties, additional work must
#   be done here to permit that.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::database (
        $password,
        $schema_source,
        $dbname='koji',
        $username='koji',
        $web_username='apache',
        $listen_addresses='localhost',
    ) {

    $schema_cmd = "psql -f ${schema_source} ${dbname} ${username}"
    $schema_flag = "/var/lib/pgsql/data/${dbname}-schema-imported.flag"
    $schema_log = "/var/lib/pgsql/data/${dbname}-schema-imported.log"
    $bstrap_cmd = "psql -c \"insert into users (name, status, usertype) values ('${::koji::params::admin_user}', 0, 0);\" ${dbname} ${username}"
    $bstrap_flag = "/var/lib/pgsql/data/${dbname}-bootstrap.flag"
    $bstrap_log = "/var/lib/pgsql/data/${dbname}-bootstrap.log"

    class { '::postgresql::server':
        listen_addresses => $listen_addresses,
    }

    Postgresql::Server::Pg_hba_rule {
        auth_method => 'trust',
        database    => $dbname,
        order       => '001',
    }

    ::postgresql::server::pg_hba_rule {
        'allow Koji-Hub via local IPv4 connection':
            type        => 'host',
            user        => $username,
            address     => '127.0.0.1/32';

        'allow Koji-Hub via local IPv6 connection':
            type        => 'host',
            user        => $username,
            address     => '::1/128';

        'allow Koji-Hub via local domain socket':
            type        => 'local',
            user        => $username;

        'allow Koji-Web via local domain socket':
            type        => 'local',
            user        => $web_username;
    } ->

    ::postgresql::server::db { $dbname:
        user     => $username,
        password => $password,
    } ->

    # Unfortunately (at this time), the puppetlabs-postgresql module provides
    # no functionality for importing a schema.  The custom postgresql_psql
    # resource type they provide would be the next best way to handle this,
    # but alas it's semi-private (i.e., undocumented, at least) and provides
    # no means of using stdin (unless the SQL does).
    exec { "import '${name}' schema":
        user    => 'root',
        creates => $schema_flag,
        command => "${schema_cmd} &> ${schema_log} && touch ${schema_flag}",
    } ->

    # Similarly, here's how we must set up the administrator authentication
    # for use with SSL certificates.
    exec { "bootstrap initial ${::koji::params::admin_user} user":
        user    => 'root',
        creates => $bstrap_flag,
        command => "${bstrap_cmd} &> ${bstrap_log} && touch ${bstrap_flag}",
    }

}

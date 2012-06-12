# modules/dart/manifests/mole.pp

class dart::mole inherits dart::abstract::workstation_node {

    include postgresql::server

}

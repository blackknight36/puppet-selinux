# modules/MODULE_NAME/examples/example.pp

# Of the class CLASS_NAME ...
$MODULE_NAME_var1 = 'X_foo'
$MODULE_NAME_var2 = 'X_bar'
$MODULE_NAME_CONFIG_NAME_source = 'puppet:///private-host/CONFIG_NAME'
include MODULE_NAME::CLASS_NAME

# Of the define DEFINE_NAME ...
MODULE_NAME::DEFINE_NAME { 'acme':
    notify  => Service['SERVICE_NAME'],
    source  => 'puppet:///private-host/MODULE_NAME/MODULE_NAME.conf',
}

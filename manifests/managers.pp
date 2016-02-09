define winsnmp::managers (
  $managers_hash,
  $key            = $title,
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\PermittedManagers'
  $manager = $managers_hash[$key]

  registry_value { "${path}\\${key}" :
    ensure => present,
    type   => 'string',
    data   => $manager,
    notify  => Service[$winsnmp::service],
  }

}
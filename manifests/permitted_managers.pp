define winsnmp::permitted_managers (
  $managers = {},
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\PermittedManagers'

  if ! empty($managers) {
    $keys = keys($managers)
    winsnmp::managers { $keys:
      managers_hash => $managers,
    }
  }

}

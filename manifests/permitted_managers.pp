define winsnmp::permitted_managers (
  $managers = {},
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\PermittedManagers'

  #Create above reg key only if it doesn't exist; Allows for multiple managers to be defined without running into multiple declarations of the same resource
  ensure_resource('registry_key', $path, {'ensure' => 'present' })

  if ! empty($managers) {
    $keys = keys($managers)
    winsnmp::managers { $keys:
      managers_hash => $managers,
    }
  }

}

# == Define: winsnmp::trap_destination
#
# Configure SNMP trap desitnations on Windows SNMP installations.
#
# See `README.md` for more details.
#
# === Authors
#
# * Levi Jarick <git@ubeek.net>
#
# === Copyright
#
# Copyright 2016 Sanoma Digital
#
#

define winsnmp::trap_destination (
  $trap,
  $dest_hash,
  $key        = $title,
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\TrapConfiguration'
  $dest = $dest_hash[$key]

  registry_value { "${path}\\${trap}\\${key}" :
    ensure => present,
    type   => 'string',
    data   => $dest,
    #notify  => Service[$winsnmp::service],
  }

}

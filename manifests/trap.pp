# == Define: winsnmp::trap
#
# Configure an SNMP trap on Windows SNMP installations.
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
#$sample_dests = { '1' => 'ptlxcs',
#                  '2' => 'cacti_ro',
#                  '3' => 'another_one' }

define winsnmp::trap (
  $trap_destinations = {},
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\TrapConfiguration'

  registry_value { "${path}":
    ensure => present,
  }

  registry_value { "${path}\\${title}":
    ensure => present,
  }

  if ! empty($trap_destinations) {
    #Create trap destination keys

    $keys = keys($trap_destinations)
    $values = values($trap_destinations)
    winsnmp::trap_destination { $keys:
      key   => $keys,
      hash  => $trap_destinations,
    }
  }

}

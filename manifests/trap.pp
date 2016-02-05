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
#$sample_dests = { '1' => 'sample1',
#                  '2' => 'cacti_ro',
#                  '3' => 'another_one' }

define winsnmp::trap (
  $trap_destinations = {},
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\TrapConfiguration'

  #Create above reg key only if it doesn't exist; Allows for multiple traps to be defined without running into multiple declarations of the same resource
  ensure_resource('registry_key', "${path}", {'ensure' => 'present' })

  registry_key { "${path}\\${title}":
    ensure => present,
  }

  if ! empty($trap_destinations) {
    #Create trap destination keys
    $keys = keys($trap_destinations)
    winsnmp::trap_destination { $keys:
      hash  => $trap_destinations,
      trap  => $title,
    }
  }

}

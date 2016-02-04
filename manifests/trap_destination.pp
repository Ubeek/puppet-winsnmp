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
#$sample_dests = { '1' => 'ptlxcs',
#                  '2' => 'cacti_ro',
#                  '3' => 'another_one' }

define winsnmp::trap_destination (
  $key,
  $hash,
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\TrapConfiguration'

$dest = $hash[$title]

notify {"Title is $title\nHash is $dest" :}


}

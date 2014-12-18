#
# Configure an RFC1156 object on Windows SNMP installations.
#
### Parameters
#
#### object
# The name of the object. Defaults to resource title.
#
#### type
# The data type of the object. This value is passed as the `type` parameter
# of a `registry_value` resource. The default is `string`. See documentation
# at http://forge.puppetlabs.com/puppetlabs/registry for details.
#
#### value
# The value the object should contain (required).
#
### Examples
#
# ```puppet
# winsnmp::object{ 'sysContact':
#   value => 'admin@example.com',
# }
#
# winsnmp::object{ 'sysServices':
#   value => '72',
#   type  => 'dword',
# }
# ```
#
### Authors
#
# * Steve Maddison <steve.maddison@sanoma.com>
#
### Copyright
#
# Copyright 2014 Sanoma Digital
#
define winsnmp::object (
  $object = $title,
  $type   = 'string',
  $value,
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\RFC1156Agent'

  registry_value { "${path}\\${object}":
    ensure => present,
    type   => $type,
    data   => $value,
    notify => Service[$winsnmp::service],
  }
}

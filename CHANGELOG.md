# CHANGELOG

## 1.0.2
  - Added new Community params to base class, 'r_communities' and 'w_communities', to allow for creation of explicitly Read-Only and Write SNMP communities while allowing for backwards compatibility with the 'communities' param. If 'r_communities' is not set, read communities will be created from the contents of the 'communities' parameter.
  - Added 'purge' parameter to base class to make removal of existing SNMP objects (PermittedManagers, ValidCommunities or RFC1156Agent) optional. Defaults to true to maintain backwards compatibility with previous module behaviour.

## 1.0.1
  - Fix lint warning re. parameter order.

## 1.0.0
  - Initial public release.
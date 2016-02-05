require 'spec_helper'

describe 'winsnmp::trap_destination', :type => 'define' do
  let(:title) { 'winsnmp::trap_destination' }

  snmp_reg_path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters'
  trap_dest = 'trapdest.internal'
  completed_regpath = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\TrapConfiguration\trapName01\1'

  context "With title '1', trap 'trapName01' and a hash of {'1' => '#{trap_dest}'}" do
    let(:title) { '1' }
    let(:params) {{
      :trap => 'trapName01',
      :dest_hash => {'1' => "#{trap_dest}"},
    }}
    it {
      should contain_registry_value("#{completed_regpath}").with({
        :ensure => 'present',
        :type   => 'string',
        :data   => "#{trap_dest}",
      })
    }
  end
end

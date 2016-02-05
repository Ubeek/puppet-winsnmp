require 'spec_helper'

describe 'winsnmp::trap', :type => 'define' do
  let(:title) { 'winsnmp::trap' }

  snmp_reg_path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters'

  context 'With a title "trapName01"' do
    let(:title) { 'trapName01' }

    it {
      should contain_registry_key("#{snmp_reg_path}\\TrapConfiguration").with({
        :ensure => 'present',
      })
      should contain_registry_key("#{snmp_reg_path}\\TrapConfiguration\\trapName01").with({
        :ensure => 'present',
      })
    }
  end

  context 'With title "trapName02" and a trap destination of "trapdest.internal"' do
    let(:title) { 'trapName02' }
    let(:params) {{
      :trap_destinations => {'1' => 'trapdest.internal'},
    }}

      should contain_registry_key("#{snmp_reg_path}\\TrapConfiguration").with({
        :ensure => 'present',
      })
      should contain_registry_key("#{snmp_reg_path}\\TrapConfiguration\\trapName01").with({
        :ensure => 'present',
      })
      should contain_snmp_trap_destination("1").with({
        :hash => {'1' => 'trapdest.internal'},
        :trap => 'trapName02',
        :key  => '1',
        })
  end
end

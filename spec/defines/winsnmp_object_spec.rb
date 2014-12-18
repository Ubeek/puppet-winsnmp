require 'spec_helper'

describe 'winsnmp::object', :type => 'define' do
  let(:title) { 'winsnmp::object' }

  object_reg_path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\RFC1156Agent'

  context 'With a title and a value.' do
    let(:title) { 'sysContact' }

    let(:params) {{
      :value => 'admin@example.com',
    }}

    it {
      should contain_registry_value("#{object_reg_path}\\sysContact").with({
        :ensure => 'present',
        :data   => 'admin@example.com',
        :type   => 'string',
      })
    }
  end

  context 'When the object name is overridden' do
    let(:title) { 'contact' }
    let(:params) {{
      :object => 'sysContact',
      :value  => 'admin@example.com',
    }}

    it { should contain_registry_value("#{object_reg_path}\\sysContact") }
  end

  context 'When no value is specified' do
    let(:title) { 'sysContact' }

    it {
      expect { should raise_error(Puppet::Error) }
    }
  end
end

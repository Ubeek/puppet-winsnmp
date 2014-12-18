require 'spec_helper'

describe 'winsnmp::community', :type => 'define' do
  let(:title) { 'winsnmp::community' }

  community_reg_path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\ValidCommunities'

  context 'With a title "public"' do
    let(:title) { 'public' }

    it {
      should contain_registry_value("#{community_reg_path}\\public").with({
        :ensure => 'present',
        :type   => 'dword',
        :data   => '4',
      })
    }
  end

  context 'When the community is overridden' do
    let(:title) { 'public' }
    let(:params) {{
      :community => 'private',
    }}

    it { should contain_registry_value("#{community_reg_path}\\private") }
  end
end

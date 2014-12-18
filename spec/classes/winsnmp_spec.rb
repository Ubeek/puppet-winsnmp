require 'spec_helper'

describe 'winsnmp', :type => 'class' do
  let(:title) { 'winsnmp' }

  context 'In the default case' do
    let(:facts) {{
      :kernel => 'windows',
    }}

    # Feature and service. 
    it { should contain_dism('SNMP') }
    it {
      should contain_service('snmp').with( {
        :ensure => 'running',
      } )
    }
  end

  context 'With community strings "public" and "private"' do
    let(:params) {{
      :communities => ['public','private']
    }}

    it { should contain_winsnmp__community('public') }
    it { should contain_winsnmp__community('private') }
  end

  context 'With custom contact, location and services' do
    $test_params = {
      'contact'  => 'Support <admin@example.com>',
      'location' => 'Data Center 1',
      'services' => '72',
    }
    let(:params) { $test_params }

    it {
      should contain_winsnmp__object('sysContact').with( {
        :value => $test_params['contact'],
        :type  => 'string',
      } )
    }
    it {
      should contain_winsnmp__object('sysLocation').with( {
        :value => $test_params['location'],
        :type  => 'string',
      } )
    }
    it {
      should contain_winsnmp__object('sysServices').with( {
        :value => $test_params['services'],
        :type  => 'dword',
      } )
    }
  end
end


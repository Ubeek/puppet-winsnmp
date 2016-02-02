require 'spec_helper'

describe 'winsnmp', :type => 'class' do
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

  context 'With community strings "public" and "another_public"' do
    let(:params) {{
      :communities => ['public','another_public']
    }}

    it { 
      should contain_winsnmp__community('public').with( {
        :security => 'READ',
      } ) 
    }
    it { 
      should contain_winsnmp__community('another_public').with( {
        :security => 'READ',      
        }) 
    }
  end

  context 'With Read-Only community strings "readonly" and "ro_community"' do
    let(:params) {{
      :r_communities => ['readonly','ro_community']
    }}

    it { 
      should contain_winsnmp__community('readonly').with( {
        :security => 'READ',
      } ) 
    }
    it { 
      should contain_winsnmp__community('ro_community').with( {
        :security => 'READ',      
        }) 
    }
  end

  context 'With Write access community strings "private" and "write"' do
    let(:params) {{
      :w_communities => ['private','write']
    }}

    it { 
      should contain_winsnmp__community('private').with( {
        :security => 'WRITE',
      } ) 
    }
    it { 
      should contain_winsnmp__community('write').with( {
        :security => 'WRITE',      
        }) 
    }
  end

  context 'With custom contact, location and services' do
    let(:params) {{
      :contact  => 'Support <admin@example.com>',
      :location => 'Data Center 1',
      :services => '72',
    }}

    it {
      should contain_winsnmp__object('sysContact').with( {
        :value => 'Support <admin@example.com>',
        :type  => 'string',
      } )
    }
    it {
      should contain_winsnmp__object('sysLocation').with( {
        :value => 'Data Center 1',
        :type  => 'string',
      } )
    }
    it {
      should contain_winsnmp__object('sysServices').with( {
        :value => '72',
        :type  => 'dword',
      } )
    }
  end
end


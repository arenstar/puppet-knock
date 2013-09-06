require 'spec_helper'
describe 'knock' do

  describe 'when using default values for class' do
    let :facts do
      { :domain   => 'example.com',
        :kernel   => 'Linux',
        :osfamily => 'RedHat',
      }
    end

    it {
      should contain_package('knock').with({
        'ensure' => 'installed',
      })
    }
  end
    it {
      should contain_package('knock-server').with({
        'ensure' => 'installed',
      })
    }
  end

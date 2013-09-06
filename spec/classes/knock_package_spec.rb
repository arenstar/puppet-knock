require 'spec_helper'

describe 'knock', :type => 'class' do
  it {
    should contain_package('knockd')
  }
end

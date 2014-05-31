require 'spec_helper'

describe 'acli', :type => :class do

  let(:params) { { :user => 'acli', :password => 'acli' } }

  it { should create_class('acli') }

end


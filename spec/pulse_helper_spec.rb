require 'spec_helper'

describe 'PulseHelper' do
  it 'should define a helper for Rails' do
    defined?(PulseHelper).should eql('constant')
  end
end

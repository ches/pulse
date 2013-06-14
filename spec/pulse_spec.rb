require File.dirname(__FILE__) + '/spec_helper.rb'

describe Pulse do
  it 'sets the ActiveRecordHealthCheck as default' do
    Pulse.health_checks.count.should eql(1)
    Pulse.health_checks.first.should be_a_kind_of(Pulse::ActiveRecordHealthCheck)
  end

  it 'allows new checks to be added' do
    Pulse.health_checks << Pulse::RedisHealthCheck.new(stub)
    Pulse.health_checks.count.should eql(2)
    Pulse.health_checks.last.should be_a_kind_of(Pulse::RedisHealthCheck)
  end
end

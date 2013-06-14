require 'spec_helper'

describe Pulse::RedisHealthCheck do
  let(:redis) { stub }
  subject { Pulse::RedisHealthCheck.new(redis) }

  it 'returns true when the connection to redis is healthy' do
    redis.should_receive(:ping).and_return('PONG')
    subject.healthy?.should be_true
  end

  it 'returns false when the connection to redis is NOT healthy' do
    redis.should_receive(:ping).and_raise(RuntimeError)
    subject.healthy?.should be_false
  end
end

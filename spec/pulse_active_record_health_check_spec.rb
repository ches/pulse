require 'spec_helper'

describe Pulse::ActiveRecordHealthCheck do
  let(:connection) { stub }

  subject { Pulse::ActiveRecordHealthCheck.new }

  before(:each) do
    ActiveRecord::Base.stub(:connection => connection)
  end

  it 'queries the sqlite3 adapter' do
    set_active_record_adapter('sqlite3')
    connection.should_receive(:execute).with('select 1').and_return(stub(:count => 1))
    subject.healthy?.should be_true
  end

  it 'queries the mysql adapter' do
    set_active_record_adapter('mysql')
    connection.should_receive(:execute).with('select 1 from dual').and_return(stub(:num_rows => 1))
    subject.healthy?.should be_true
  end

  it 'queries the mysql2 adapter' do
    set_active_record_adapter('mysql2')
    connection.should_receive(:execute).with('select 1 from dual').and_return(stub(:count => 1))
    subject.healthy?.should be_true
  end

  it 'queries the postgresql adapter' do
    set_active_record_adapter('postgresql')
    connection.should_receive(:execute).with('select 1').and_return(stub(:count => 1))
    subject.healthy?.should be_true
  end

  it 'queries the postgis adapter' do
    set_active_record_adapter('postgis')
    connection.should_receive(:execute).with('select 1').and_return(stub(:count => 1))
    subject.healthy?.should be_true
  end

  it 'raises an error if the adapter is not recogized' do
    set_active_record_adapter('webscale')
    expect { subject.healthy? }.to raise_error("Don't know how to check webscale... please to fix?")
  end
end

require 'spec_helper'

describe PulseController do
  subject { PulseController.new }

  before(:each) do
    time_stub = stub(:now => stub(:utc => stub(:to_s => '2013-06-14 15:48:24')))
    stub_const('ActionController::Base::Time', time_stub)
  end

  describe 'ActiveRecord' do
    before(:each) do
      set_active_record_adapter('mysql2')
    end

    describe 'is healthy' do
      before(:each) do
        ActiveRecord::Base.stub(:connection => stub(:execute => [stub]))
      end

      it 'returns a 200 response' do
        subject.should_receive(:render).with(:text => '<html><body>OK  2013-06-14 15:48:24</body></html>')
        subject.pulse
      end
    end

    describe 'is NOT healthy' do
      before(:each) do
        ActiveRecord::Base.stub(:connection).stub(:execute).and_raise(RuntimeError)
      end

      it 'returns a 500 response' do
        subject.should_receive(:render).with(:text => '<html><body>ERROR</body></html>', :status => :internal_server_error)
        subject.pulse
      end
    end
  end
end

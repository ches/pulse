require File.dirname(__FILE__) + '/spec_helper.rb'

describe Pulse do

  describe 'helper' do
    it 'should define a helper for Rails' do
      defined?(PulseHelper).should eql('constant')
    end
  end

  describe 'routing' do
    describe 'rails 2' do
      subject do
        stub_const("Rails::VERSION::MAJOR", 2)
        load 'pulse/routes.rb'
        ActionController::Routing::RouteSet::Mapper.new
      end

      describe '#pulse' do
        it 'sets up a route at /pulse' do
          subject.should_receive(:connect).with('/pulse', :controller => 'pulse', :action => 'pulse')
          subject.pulse
        end

        it 'sets up a route at /admin/pulse' do
          subject.should_receive(:connect).with('/admin/pulse', :controller => 'pulse', :action => 'pulse')
          subject.pulse('/admin/pulse')
        end
      end
    end

    describe 'rails 3' do
      subject do
        stub_const('Rails::VERSION::MAJOR', 3)
        load 'pulse/routes.rb'
        ActionDispatch::Routing::Mapper.new
      end

      describe '#pulse' do
        it 'sets up a route at /pulse' do
          subject.should_receive(:get).with('/pulse' => 'pulse#pulse')
          subject.pulse
        end

        it 'sets up a route at /admin/pulse' do
          subject.should_receive(:get).with('/admin/pulse' => 'pulse#pulse')
          subject.pulse('/admin/pulse')
        end
      end
    end
  end

  describe 'response' do
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
end

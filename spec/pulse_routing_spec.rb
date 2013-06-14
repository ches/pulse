require 'spec_helper'


describe 'Pulse::Routes' do
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


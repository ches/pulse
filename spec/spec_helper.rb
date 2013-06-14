$LOAD_PATH.unshift 'lib/'

module Rails
  module VERSION
    STRING = '3.2.13'
    MAJOR = 3
  end
end

module ActiveRecord
  class Base
  end
end

module ActionController
  class Base
  end
end

# Rails 3
module ActionDispatch
  module Routing
    class Mapper
    end
  end
end

# Rails 2
module ActionController
  module Routing
    class RouteSet
      class Mapper
      end
    end
  end
end

module Helpers
  def set_active_record_adapter(adapter)
    ActiveRecord::Base.stub(:connection_pool => stub(:spec => stub(:config => { :adapter => adapter })))
  end
end

RSpec.configure do |config|
  config.include Helpers
end

require 'pry'
require 'rails-pulse'

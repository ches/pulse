require 'pulse/controller'
require 'pulse/helper'
require 'pulse/routes'

module Pulse
  autoload 'ActiveRecordHealthCheck', 'pulse/active_record_health_check'

  extend self

  def health_checks
    @health_checks ||= [ Pulse::ActiveRecordHealthCheck.new ]
  end
end

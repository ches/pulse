class PulseController < ActionController::Base
  session :off unless Rails::VERSION::STRING >= "2.3"

  # The pulse action runs health checks on the app.
  # If a sane result is returned from each check, 'OK'
  # is displayed and a 200 response code is returned. If
  # not, 'ERROR' is displayed and a 500 response code is
  # returned.
  def pulse
    if all_checks_healthy?
      render :text => okay_response
    else
      render :text => error_response, :status => :internal_server_error
    end
  end

  protected 

  # cancel out loggin for the PulseController by defining logger as <tt>nil</tt>
  def logger
    nil
  end

  def all_checks_healthy?
    Pulse.health_checks.map do |check|
      check.healthy?
    end.uniq == [true]
  end

  def okay_response
    "<html><body>OK  #{Time.now.utc.to_s(:db)}</body></html>"
  end

  def error_response
    '<html><body>ERROR</body></html>'   
  end
end

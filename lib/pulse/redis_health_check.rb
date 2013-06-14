module Pulse
  class RedisHealthCheck
    attr_reader :redis

    def initialize(redis)
      @redis = redis
    end

    def healthy?
      begin
        redis.ping == 'PONG'
      rescue
        false
      end
    end
  end
end

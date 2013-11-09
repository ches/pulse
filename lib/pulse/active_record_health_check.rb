module Pulse
  class ActiveRecordHealthCheck
    def healthy?
      health_method = "#{active_record_adapter}_healthy?"
      if respond_to?(health_method, true)
        send(health_method)
      else
        raise "Don't know how to check #{active_record_adapter}... please to fix?"
      end
    end

    def sqlite3_healthy?
      select_one_count == 1
    end

    def mysql_healthy?
      select_one_from_dual_num_rows == 1
    end

    def mysql2_healthy?
      select_one_from_dual_count == 1
    end

    def postgresql_healthy?
      select_one_count == 1
    end
    
    alias_method :postgis_healthy?, :postgresql_healthy?

    private

    def active_record_adapter
      ActiveRecord::Base::connection_pool.spec.config[:adapter]
    end

    def select_one_count
      begin
        ActiveRecord::Base.connection.execute("select 1").count
      rescue
        0
      end
    end

    def select_one_from_dual_count
      begin
        ActiveRecord::Base.connection.execute("select 1 from dual").count
      rescue
        0
      end
    end

    def select_one_from_dual_num_rows
      begin
        ActiveRecord::Base.connection.execute("select 1 from dual").num_rows
      rescue
        0
      end
    end
  end
end


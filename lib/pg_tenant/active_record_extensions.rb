module PgTenant

  module ActiveRecordExtensions
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_tenant
        print "type: #{type}"
      end
    end
  end
end

ActiveRecord::Base.send(:include, PgTenant::ActiveRecordExtensions)

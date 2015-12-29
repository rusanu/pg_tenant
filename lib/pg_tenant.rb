require 'pg_tenant/version'
require 'pg_tenant/engine'
require 'forwardable'

module PgTenant

  class << self
    extend Forwardable

    ACCESSOR_METHODS = [:configurations]
    WRITER_METHODS = [:connection_class]

    attr_accessor(*ACCESSOR_METHODS)
    attr_writer(*WRITER_METHODS)

    def_delegators :connection_class, 
      :connection, 
      :connection_config, 
      :establish_connection,
      :configurations

    def connection_class
      @connection_class || ActiveRecord::Base
    end

    def master_connection_spec
      
    end

    def is_current_type(type)
      return type == :all ||
        (self.is_tenant? && (type == :tenant)) ||
        (self.is_master? && (type == :master))
    end

    def is_tenant?
      return !self.Tenant.nil?
    end

    def is_master?
      return self.Tenant.nil?
    end

    def Tenant
      Thread.current[:PgTenant]
      self.establish_connection tenant.nil? ? master_connection_spec : tenant.connection_spec
    end

    def Tenant=(tenant)
      Thread.current[:PgTenant] = tenant
    end

    def tenant_id
      self.is_tenant? ? self.Tenant.id : nil
    end

    def tenant_id=(id)
      if (id.nil?)
        self.Tenant = nil
      else
        self.Tenant = Tenant.find(id)
      end
    end

    def with_tenant(tenant)
      old = self.Tenant
      self.Tenant = tenant
      begin
        yield
      ensure
        self.Tenant = old
      end
    end

    def all_tenants
      Tenant.all.each do |tenant|
        self.with_tenant(tenant) do
          yield
        end
      end
    end
    
  end
end

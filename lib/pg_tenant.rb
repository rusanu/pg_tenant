require 'pg_tenant/version'
require 'pg_tenant/engine'
require 'forwardable'

module PgTenant

  class << self
    extend Forwardable

    ACCESSOR_METHODS = []
    WRITER_METHODS = [:connection_class]

    attr_accessor(*ACCESSOR_METHODS)
    attr_writer(*WRITER_METHODS)

    def_delegators :connection_class, 
      :connection, 
      :connection_config, 
      :establish_connection

    def connection_class
      @connection_class || ActiveRecord::Base
    end
    
  end
end

require 'active_support/concern'

module PgTenant
  module MigrationExtensions
    extend ActiveSupport::Concern

    module ClassMethods

      def pg_tenant(type)
        self.class_eval do
          old_exec_migration = instance_method(:exec_migration)

          define_method(:exec_migration) do |connection, options|
            if PgTenant.is_current_type(type)
              old_exec_migration.bind(self).(connection, options)
            end
          end
        end
      end
    end
  end
end

ActiveRecord::Migration.send(:include, PgTenant::MigrationExtensions)

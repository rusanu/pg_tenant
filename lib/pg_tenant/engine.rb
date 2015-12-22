
module PgTenant
  class Engine < ::Rails::Engine
    isolate_namespace PgTenant

    initializer :append_migrations do |app|
      config.paths['db/migrate'].expanded.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end
  end
end

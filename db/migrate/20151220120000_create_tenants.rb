class CreateTenants < ActiveRecord::Migration
  pg_tenant :master

  def change
    create_table :tenants do |t|
      t.string :tenant_name, null: false
      t.string :adapter, null: false
      t.string :host_name
      t.integer :port
      t.string :database_name
      t.string :schema_name
      t.text :options
      t.integer :status
      t.timestamps null: false
    end

    add_index :tenants, [:tenant_name], unique: true

  end
end


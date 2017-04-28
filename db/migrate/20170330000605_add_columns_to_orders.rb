class AddColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :billing_country,  :string
    add_column :orders, :billing_zip,      :integer
    add_column :orders, :billing_address,  :string
    add_column :orders, :billing_city,     :string
    add_column :orders, :billing_state,    :string
    add_column :orders, :shipping_name,    :string
    add_column :orders, :shipping_country, :string
    add_column :orders, :shipping_zip,     :integer
    add_column :orders, :shipping_address, :string
    add_column :orders, :shipping_city,    :string
    add_column :orders, :shipping_state,   :string
  end
end

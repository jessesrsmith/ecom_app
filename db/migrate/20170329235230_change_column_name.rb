class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :orders, :name, :billing_name
  end
end

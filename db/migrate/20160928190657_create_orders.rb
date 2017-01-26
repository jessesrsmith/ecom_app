class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.decimal :total

      t.timestamps null: false
    end
  end
end

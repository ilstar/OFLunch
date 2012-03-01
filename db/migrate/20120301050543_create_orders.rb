class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :meal_time_id

      t.timestamps
    end
  end
end

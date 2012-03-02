class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :menu_item_id
      t.float :price
      t.integer :amount

      t.timestamps
    end
  end
end

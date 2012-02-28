class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name
      t.float :price
      t.string :serial_num
      t.integer :vendor_id

      t.timestamps
    end
  end
end

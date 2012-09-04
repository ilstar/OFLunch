class RemoveColumnSerialNumFromMenuItems < ActiveRecord::Migration
  def up
    remove_column :menu_items, :serial_num
  end

  def down
    add_column :menu_items, :serial_num, :string
  end
end

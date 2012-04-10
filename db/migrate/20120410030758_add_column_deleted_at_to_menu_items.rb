class AddColumnDeletedAtToMenuItems < ActiveRecord::Migration
  def change
    add_column :menu_items, :deleted_at, :datetime

  end
end

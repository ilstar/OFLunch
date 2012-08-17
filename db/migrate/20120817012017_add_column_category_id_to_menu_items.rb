class AddColumnCategoryIdToMenuItems < ActiveRecord::Migration
  def change
    add_column :menu_items, :category_id, :integer

    add_index :menu_items, :category_id
  end
end

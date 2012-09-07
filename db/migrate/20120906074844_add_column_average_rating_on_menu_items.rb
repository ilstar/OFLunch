class AddColumnAverageRatingOnMenuItems < ActiveRecord::Migration
  def up
    add_column :menu_items, :average_rating, :float
  end

  def down
    remove_column :menu_items, :average_rating
  end
end

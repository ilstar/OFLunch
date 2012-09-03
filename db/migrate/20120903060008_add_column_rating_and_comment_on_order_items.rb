class AddColumnRatingAndCommentOnOrderItems < ActiveRecord::Migration
  def up
    add_column :order_items, :rating, :integer
    add_column :order_items, :comment, :text
  end

  def down
    remove_column :order_items, :rating
    remove_column :order_items, :comment
  end
end

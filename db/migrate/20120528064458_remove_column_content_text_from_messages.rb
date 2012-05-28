class RemoveColumnContentTextFromMessages < ActiveRecord::Migration
  def up
    remove_column :messages, :content
  end

  def down
    add_column :messages, :content, :text
  end
end

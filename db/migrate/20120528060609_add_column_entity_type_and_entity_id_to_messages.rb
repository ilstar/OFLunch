class AddColumnEntityTypeAndEntityIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :entity_type, :string, null: false
    add_column :messages, :entity_id, :integer, null: false

    add_index :messages, [:entity_type, :entity_id]
  end
end

class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :recipient_id
      t.boolean :read, default: false

      t.timestamps
    end
  end
end

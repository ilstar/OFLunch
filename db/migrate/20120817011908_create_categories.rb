class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :identifier
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

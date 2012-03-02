# -*- encoding : utf-8 -*-
class CreateMenuOfMeals < ActiveRecord::Migration
  def change
    create_table :menu_of_meals do |t|
      t.integer :vendor_id
      t.integer :meal_time_id

      t.timestamps
    end
  end
end

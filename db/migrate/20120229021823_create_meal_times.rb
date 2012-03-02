# -*- encoding : utf-8 -*-
class CreateMealTimes < ActiveRecord::Migration
  def change
    create_table :meal_times do |t|

      t.timestamps
    end
  end
end

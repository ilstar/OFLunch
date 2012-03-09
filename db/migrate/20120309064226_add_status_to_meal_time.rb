class AddStatusToMealTime < ActiveRecord::Migration
  def change
    add_column :meal_times, :status, :string
  end
end

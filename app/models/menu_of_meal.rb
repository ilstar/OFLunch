class MenuOfMeal < ActiveRecord::Base
  belongs_to :meal_time
  belongs_to :vendor

  validate :less_than_two_vendors_choosed

  protected

  def less_than_two_vendors_choosed
    if self.meal_time.menu_of_meals.count >= 2
      self.errors.add :base, "can't adding more than 2."
    end
  end
end

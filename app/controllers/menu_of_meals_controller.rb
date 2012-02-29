class MenuOfMealsController < ApplicationController
  def index
    @vendors = Vendor.all
    @meal_time = MealTime.find params[:meal_time_id]
  end

  def create
    @meal_time = MealTime.find params[:meal_time_id]
    @menu_of_meal = MenuOfMeal.new meal_time_id: params[:meal_time_id], vendor_id: params[:vendor_id]

    if @menu_of_meal.save
      redirect_to meal_time_menu_of_meals_url(@menu_of_meal.meal_time_id)
    else
      @vendors = Vendor.all
      flash.now[:alert] = @menu_of_meal.errors[:base].join ' '
      render 'index'
    end
  end

  def destroy
    @menu_of_meal = MenuOfMeal.find params[:id]
    @menu_of_meal.destroy

    redirect_to meal_time_menu_of_meals_url(@menu_of_meal.meal_time_id)
  end
end

class MealTimesController < ApplicationController
  def index
    @today_meal_time = MealTime.today

    redirect_to meal_time_menu_of_meals_url(@today_meal_time) if @today_meal_time
  end

  def create
    @meal_time = MealTime.new(params[:meal_time])

    respond_to do |format|
      if @meal_time.save
        format.html { redirect_to meal_time_menu_of_meals_url(@meal_time) }
      end
    end
  end

end

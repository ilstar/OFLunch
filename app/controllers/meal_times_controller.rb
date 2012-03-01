class MealTimesController < ApplicationController
  def index
    @today_meal_time = MealTime.today
  end

  def new
    @meal_time = MealTime.new
  end


  def create
    @meal_time = MealTime.new(params[:meal_time])

    respond_to do |format|
      if @meal_time.save
        format.html { redirect_to meal_times_url }
      else
        format.html { render :action => "new" }
      end
    end
  end

end

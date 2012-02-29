class MealTimesController < ApplicationController
  # GET /meal_times
  # GET /meal_times.json
  def index
    @meal_times = MealTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meal_times }
    end
  end

  # GET /meal_times/1
  # GET /meal_times/1.json
  def show
    @meal_time = MealTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meal_time }
    end
  end

  # GET /meal_times/new
  # GET /meal_times/new.json
  def new
    @meal_time = MealTime.new
    @vendors = Vendor.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meal_time }
    end
  end

  # GET /meal_times/1/edit
  def edit
    @meal_time = MealTime.find(params[:id])
  end

  # POST /meal_times
  # POST /meal_times.json
  def create
    @meal_time = MealTime.new(params[:meal_time])

    respond_to do |format|
      if @meal_time.save
        format.html { redirect_to @meal_time, notice: 'Meal time was successfully created.' }
        format.json { render json: @meal_time, status: :created, location: @meal_time }
      else
        format.html { render action: "new" }
        format.json { render json: @meal_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meal_times/1
  # PUT /meal_times/1.json
  def update
    @meal_time = MealTime.find(params[:id])

    respond_to do |format|
      if @meal_time.update_attributes(params[:meal_time])
        format.html { redirect_to @meal_time, notice: 'Meal time was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meal_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meal_times/1
  # DELETE /meal_times/1.json
  def destroy
    @meal_time = MealTime.find(params[:id])
    @meal_time.destroy

    respond_to do |format|
      format.html { redirect_to meal_times_url }
      format.json { head :no_content }
    end
  end
end

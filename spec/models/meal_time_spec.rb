# -*- encoding : utf-8 -*-
require 'spec_helper'

describe MealTime do
  it { should have_many(:menu_of_meals).dependent(:destroy) }
  it { should have_many(:vendors).through(:menu_of_meals) }

  before do
    @meal_time = Factory(:meal_time)
  end

  describe "unlocked?" do
    it "be true after meal_time created" do
      @meal_time.unlocked?.should be_true
    end

    it "be false after meal_time locked" do
      @meal_time.lock!

      @meal_time.unlocked?.should be_false
    end

    it "be true after meal_time unlock" do
      @meal_time.lock!
      @meal_time.unlock!

      @meal_time.unlocked?.should be_true
    end
  end

  describe "unlock!" do
    it "unlocked? will be true after unlock!" do
      @meal_time.lock!
      @meal_time.unlocked?.should be_false

      @meal_time.unlock!
      @meal_time.unlocked?.should be_true
    end
  end
end

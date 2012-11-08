# -*- encoding : utf-8 -*-
require 'spec_helper'

describe MealTime do
  it { should have_many(:menu_of_meals).dependent(:destroy) }
  it { should have_many(:vendors).through(:menu_of_meals) }

  before do
    @meal_time = FactoryGirl.create(:meal_time)
  end

  describe ".opened" do
    it "can't create more than one meal time in certian duration" do
      @new_meal_time = FactoryGirl.build :meal_time
      @new_meal_time.valid?.should be_false
    end

    it "could create 2 meal time in same day but not in same duration" do
      MealTime.destroy_all

      Timecop.freeze ActiveSupport::TimeZone[Time.zone.name].parse('2012-11-07 10:00') do
        FactoryGirl.create :meal_time
      end

      Timecop.freeze ActiveSupport::TimeZone[Time.zone.name].parse('2012-11-07 16:00') do
        FactoryGirl.create :meal_time
      end
    end
  end

  describe ".by_date" do
    it "be nil when have no meal_time at that date" do
      MealTime.by_date('2019-01-01').should be_nil
    end

    it "get one by date" do
      d = Time.parse('2012-03-03 12:00:00')
      Timecop.freeze(d) do
        FactoryGirl.create(:meal_time)
      end
      MealTime.by_date('2012-03-03').should_not be_nil
    end
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

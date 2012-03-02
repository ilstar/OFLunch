# -*- encoding : utf-8 -*-
require 'spec_helper'

describe MealTime do
  it { should have_many(:menu_of_meals).dependent(:destroy) }
  it { should have_many(:vendors).through(:menu_of_meals) }
end

require 'spec_helper'

describe MenuOfMeal do
  it { should belong_to(:meal_time) }
  it { should belong_to(:vendor) }
end

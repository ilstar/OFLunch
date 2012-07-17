require 'spec_helper'

describe "order_items/index" do

	describe "user login" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			@meal_time = FactoryGirl.create(:meal_time)
			@order = FactoryGirl.create(:order, user: @user, meal_time: @meal_time)
			@order_item = FactoryGirl.create(:order_item, order: @order)

			sign_in @user
		end

		it "successfully rendered" do
			render

			# p rendered, there is a variable named 'rendered' which includes response.
			assert_select "div"
		end
	end

end

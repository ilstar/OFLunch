require 'spec_helper'

describe "order_items/index" do

	describe "user login" do
		before(:each) do
			@user = Factory(:user)
			@meal_time = Factory(:meal_time)
			@order = Factory(:order, user: @user, meal_time: @meal_time)
			@order_item = Factory(:order_item, order: @order)

			sign_in @user
		end

		it "successfully rendered" do
			render

			# p rendered, there is a variable named 'rendered' which includes response.
			assert_select "div"
		end
	end

end

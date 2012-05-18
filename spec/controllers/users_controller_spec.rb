require 'spec_helper'

describe UsersController do
	before do
	  @user = Factory(:user)

	  sign_in @user
	end

	describe "GET edit_password" do
	  it "successfully rendered" do
	    get :edit_password

	    response.should be_success
	  end
	end

	describe "GET edit" do
	  it "successfully rendered" do
	    get :edit

	    response.should be_success
	  end
	end

end

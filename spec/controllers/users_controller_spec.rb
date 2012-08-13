require 'spec_helper'

describe UsersController do
	before do
		@password = 'abcdefjj'
	  @user = FactoryGirl.create(:user, password: @password)

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

  describe "PUT update" do
    describe "with valid params" do
      it "updates name successfully" do
        new_name = 'newnameneverseenbefore'

        put :update, {user: {name: new_name}}

        assigns(:user).name.should == new_name
      end

      it "redirects to edit template" do
        put :update, {user: {name: 'foo'}}

        response.should redirect_to(edit_user_url)
      end

      it "can't update other fields" do
        put :update, {user: {name: 'foo', email: 'newmail@mail.com'}}

        assigns(:user).email.should == @user.email
      end
    end

    describe "with invalid params" do
      it "rendered edit template" do
        put :update, {user: {name: ''}}

        response.should render_template('edit')
      end
    end
  end

  describe "PUT update_password" do
    describe "with valid password" do
      it "has new correct password" do
        new_password = 'blabla234'

        put :update_password, user: {current_password: @password, password: new_password, password_confirmation: new_password}

        assigns(:user).valid_password?(new_password).should be_true
      end

      it "redirect to edit_password page" do
        new_password = 'blabla234'

        put :update_password, user: {current_password: @password, password: new_password, password_confirmation: new_password}

        response.should redirect_to(edit_password_user_url)
      end
    end

    describe "with invalid password" do
      it "rendered edit password template" do
        put :update_password, user: {current_password: '', password: '', password_confirmation: ''}

        response.should render_template('edit_password')
      end
    end
  end

end

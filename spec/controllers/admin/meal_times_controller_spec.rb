# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::MealTimesController do
  before do
    @user = FactoryGirl.create(:admin)
    @meal_time = FactoryGirl.create(:meal_time)
    
    sign_in @user
  end

  describe "GET index" do
    it "successfully rendered when no today meal time" do
      MealTime.destroy_all

      get :index

      response.should be_success
    end

    it "successfully rendered when today meal time is created" do
      MealTime.today.should_not be_nil

      get :index

      response.should be_success
    end
  end

  describe "PUT unlock" do
    before do
      @meal_time.lock!
    end

    it "redirect to order_items_url after unlock" do
      put :unlock, id: @meal_time.id.to_s

      response.should redirect_to(order_items_url)
      assigns(:meal_time).unlocked?.should be_true
      controller.flash.notice.should_not be_nil
    end
  end

  describe "POST create" do
    before do
      MealTime.destroy_all
      @vendor1 = FactoryGirl.create :vendor
    end

    describe "with valid attributes" do
      it "create a new MealTime" do
        lambda {
          post :create, meal_time: { vendor_ids: [@vendor1.to_param] }
        }.should change{ MealTime.count }.by(1)
      end

      it "redirect to index" do
        post :create, meal_time: { vendor_ids: [@vendor1.to_param] }
        
        response.should redirect_to(admin_meal_times_url)
      end
    end

    describe "with invalid attributes" do
      it "can't create MealTime without vendor" do
        lambda {
          post :create, meal_time: { vendor_ids: [] }
        }.should change{ MealTime.count }.by(0)

        response.should render_template('index')
      end
    end
  end

  describe "close" do
    it "close successfully" do
      put :close, id: @meal_time.id.to_s

      response.should redirect_to(order_items_url)
      controller.flash.notice.should == '菜单已关闭，扣钱成功'
    end

    it "will not close because it already closed" do
      @meal_time.close!

      put :close, id: @meal_time.id.to_s

      response.should redirect_to(order_items_url)
      controller.flash.notice.should == '菜单已经关闭，无需重复操作'
    end
  end

  # # This should return the minimal set of attributes required to create a valid
  # # MealTime. As you add validations to MealTime, be sure to
  # # update the return value of this method accordingly.
  # def valid_attributes
  #   {}
  # end
  # 
  # # This should return the minimal set of values that should be in the session
  # # in order to pass any filters (e.g. authentication) defined in
  # # MealTimesController. Be sure to keep this updated too.
  # def valid_session
  #   {}
  # end

  # describe "GET index" do
  #   it "assigns all meal_times as @meal_times" do
  #     meal_time = MealTime.create! valid_attributes
  #     get :index, {}, valid_session
  #     assigns(:meal_times).should eq([meal_time])
  #   end
  # end

  # describe "GET show" do
  #   it "assigns the requested meal_time as @meal_time" do
  #     meal_time = MealTime.create! valid_attributes
  #     get :show, {:id => meal_time.to_param}, valid_session
  #     assigns(:meal_time).should eq(meal_time)
  #   end
  # end

  # describe "GET new" do
  #   it "assigns a new meal_time as @meal_time" do
  #     get :new, {}, valid_session
  #     assigns(:meal_time).should be_a_new(MealTime)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested meal_time as @meal_time" do
  #     meal_time = MealTime.create! valid_attributes
  #     get :edit, {:id => meal_time.to_param}, valid_session
  #     assigns(:meal_time).should eq(meal_time)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new MealTime" do
  #       expect {
  #         post :create, {:meal_time => valid_attributes}, valid_session
  #       }.to change(MealTime, :count).by(1)
  #     end

  #     it "assigns a newly created meal_time as @meal_time" do
  #       post :create, {:meal_time => valid_attributes}, valid_session
  #       assigns(:meal_time).should be_a(MealTime)
  #       assigns(:meal_time).should be_persisted
  #     end

  #     it "redirects to the created meal_time" do
  #       post :create, {:meal_time => valid_attributes}, valid_session
  #       response.should redirect_to(MealTime.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved meal_time as @meal_time" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       MealTime.any_instance.stub(:save).and_return(false)
  #       post :create, {:meal_time => {}}, valid_session
  #       assigns(:meal_time).should be_a_new(MealTime)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       MealTime.any_instance.stub(:save).and_return(false)
  #       post :create, {:meal_time => {}}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested meal_time" do
  #       meal_time = MealTime.create! valid_attributes
  #       # Assuming there are no other meal_times in the database, this
  #       # specifies that the MealTime created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       MealTime.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, {:id => meal_time.to_param, :meal_time => {'these' => 'params'}}, valid_session
  #     end

  #     it "assigns the requested meal_time as @meal_time" do
  #       meal_time = MealTime.create! valid_attributes
  #       put :update, {:id => meal_time.to_param, :meal_time => valid_attributes}, valid_session
  #       assigns(:meal_time).should eq(meal_time)
  #     end

  #     it "redirects to the meal_time" do
  #       meal_time = MealTime.create! valid_attributes
  #       put :update, {:id => meal_time.to_param, :meal_time => valid_attributes}, valid_session
  #       response.should redirect_to(meal_time)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the meal_time as @meal_time" do
  #       meal_time = MealTime.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       MealTime.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => meal_time.to_param, :meal_time => {}}, valid_session
  #       assigns(:meal_time).should eq(meal_time)
  #     end

  #     it "re-renders the 'edit' template" do
  #       meal_time = MealTime.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       MealTime.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => meal_time.to_param, :meal_time => {}}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested meal_time" do
  #     meal_time = MealTime.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => meal_time.to_param}, valid_session
  #     }.to change(MealTime, :count).by(-1)
  #   end

  #   it "redirects to the meal_times list" do
  #     meal_time = MealTime.create! valid_attributes
  #     delete :destroy, {:id => meal_time.to_param}, valid_session
  #     response.should redirect_to(meal_times_url)
  #   end
  # end

end

require 'spec_helper'

describe BillsController do

  before do
    @user = Factory(:user)

    sign_in @user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'

      response.should be_success
    end
    
    it "successfully rendered with year and month" do
      get :index, year: '2012', month: '05'

      response.should be_success
    end
  end

end

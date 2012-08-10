require 'spec_helper'

describe VendorsController do

  before do
    @user = FactoryGirl.create :user

    sign_in @user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'

      response.should be_success
    end
  end

end

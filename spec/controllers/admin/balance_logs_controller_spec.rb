require 'spec_helper'

describe Admin::BalanceLogsController do
  before do
    @user = FactoryGirl.create(:admin)

    sign_in @user
  end

  describe "POST create" do
    it "increase correct amount" do
      expect {
        post :create, balance_log: {amount: '100', balance_id: @user.balance.to_param}
      }.to change { @user.balance.reload.amount }.by(100)
    end
  end

end

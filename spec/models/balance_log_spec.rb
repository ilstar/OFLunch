require 'spec_helper'

describe BalanceLog do
  describe "after create" do
    it "create a message" do
      user = FactoryGirl.create :user

      lambda {
        FactoryGirl.create :balance_log, balance: user.balance
      }.should change{ user.unread_messages.count }.by(1)
    end
  end
end

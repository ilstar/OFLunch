# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  before do
    @user = Factory(:user)
  end

  describe "#admin?" do
    it "true when he is admin" do
      @user.update_attribute :role, 'admin'
      @user.admin?.should be_true
    end

    it "false when he is not admin" do
      @user.admin?.should be_false
    end
  end

  describe "balance" do
    it "auto create balance after user created" do
      lambda {
        Factory(:user)
      }.should change{ Balance.count }.by(1)
    end

    it "balance is 0 default" do
      user = Factory(:user)

      user.account_balance.should == 0
    end
  end
end

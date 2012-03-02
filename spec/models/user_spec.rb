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
end

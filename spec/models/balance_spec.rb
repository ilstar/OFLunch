require 'spec_helper'

describe Balance do
  describe ".remaining_sum" do
    it "get correct result" do
      b1 = Factory(:balance, amount: 15)
      b2 = Factory(:balance)
      b3 = Factory(:balance, amount: -3)

      Balance.remaining_sum.should == 12
    end
  end
end

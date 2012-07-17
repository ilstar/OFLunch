require 'spec_helper'

describe BalanceLogsController do
  before do
    @user = FactoryGirl.create(:user)

    sign_in @user
  end

end

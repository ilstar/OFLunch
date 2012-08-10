require 'spec_helper'

describe Admin::BalanceLogsController do
  before do
    @user = FactoryGirl.create(:user)

    sign_in @user
  end

end

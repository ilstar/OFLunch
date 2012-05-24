require 'spec_helper'

describe BalanceLogsController do
  before do
    @user = Factory(:user)

    sign_in @user
  end

end

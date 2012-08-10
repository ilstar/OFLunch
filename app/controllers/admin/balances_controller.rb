class Admin::BalancesController < Admin::BaseController
  set_tab :balances

  def index
    @balances = Balance.includes(:user).order('users.name ASC')

    respond_to do |format|
      format.html # index.html.erb
    end
  end

end

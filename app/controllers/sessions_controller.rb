class SessionsController < ApplicationController
  before_filter :admin_required

  def index
    @users = User.where("id != ?", current_user.id).order('name').all

    render layout: false
  end

  def change
    if params[:user_id]
      self.original_user = current_user
      sign_in User.find(params[:user_id])
    else
      sign_in original_user
      self.original_user = nil
    end

    redirect_to :back
  end

  protected

  def admin_required
    head 403 if original_user.nil? and !current_user.admin?
  end
end

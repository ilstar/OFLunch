# -*- encoding : utf-8 -*-

class UsersController < ApplicationController
  layout 'application'
  before_filter :only_admin_and_user_himself_can_change_user, :except => :edit

  def edit
    @user = User.find_by_id(params[:user_id]) || current_user
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to account_path(:user_id => @user.id), :notice => "修改成功"
    else
      render :action => "edit", :user_id => params[:user_id]
    end
  end

  private
  def only_admin_and_user_himself_can_change_user
    @user = User.find_by_id(params[:user_id])
    redirect_to account_path(:user_id => @user.id), :notice => "不能编辑此账户信息" if not @user.can_access_by?(current_user)
  end
end

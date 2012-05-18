# -*- encoding : utf-8 -*-

class UsersController < ApplicationController
  layout 'application'
  before_filter :load_current_user

  def edit
  end

  def edit_password
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path, :notice => "修改成功"
    else
      render :action => "edit"
    end
  end

  def update_password
    if @user.update_with_password(params[:user])
      redirect_to edit_password_user_path, :notice => "修改成功"
    else
      render "edit_password"
    end
  end

  protected

  def load_current_user
    @user = current_user
  end

end

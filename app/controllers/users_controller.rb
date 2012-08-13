# -*- encoding : utf-8 -*-

class UsersController < ApplicationController
  layout 'application'
  before_filter :load_current_user

  def edit
  end

  def edit_password
  end

  def update
    reject_other_fields_for_update
    if @user.update_attributes(params[:user])
      redirect_to edit_user_url, :notice => "修改成功"
    else
      render "edit"
    end
  end

  def update_password
    reject_other_fields_for_update_password
    if @user.update_with_password(params[:user])
      redirect_to edit_password_user_url, :notice => "修改成功"
    else
      render "edit_password"
    end
  end

  protected

  def load_current_user
    @user = current_user
  end

  def reject_other_fields_for_update
    params[:user].reject! { |k, v| not %w{name}.include?(k) }
  end

  def reject_other_fields_for_update_password
    params[:user].reject! { |k, v| not %w{current_password password password_confirmation}.include?(k) }
  end

end

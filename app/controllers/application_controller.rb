# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :check_unread_messages
  layout :layout_by_resource

  helper_method :original_user

  def layout_by_resource
    if devise_controller?
      'users'
    else
      'application'
    end
  end

  def admin_required
    redirect_to root_path, :notice => "无权访问" unless current_user.try(:admin?)
  end

  def original_user
    User.find_by_id(session[:original_user_id])
  end

  protected

  # user can be nil if you want reset original_user
  def original_user=(user)
    session[:original_user_id] = user.try(:id)
  end

  def check_unread_messages
    @messages = current_user ? current_user.unread_messages : []
  end
end

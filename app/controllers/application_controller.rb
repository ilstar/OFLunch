# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :check_unread_messages
  layout :layout_by_resource

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

  protected

  def check_unread_messages
    @messages = current_user ? current_user.messages : []
  end
end

# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      'users'
    else
     'application'
    end
  end
end

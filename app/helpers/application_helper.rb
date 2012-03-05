# -*- encoding : utf-8 -*-
module ApplicationHelper
  def icon_helper(icon)
    content_tag(:i, :class => icon) 
  end
end

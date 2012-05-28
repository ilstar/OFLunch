# -*- encoding : utf-8 -*-
module ApplicationHelper
  def icon_helper(icon)
    content_tag(:i, :class => icon) 
  end

  def warning_alert(msg)
    raw %{
    <div class="alert">
      <a class="close" data-dismiss="alert">×</a>
      #{msg}
    </div>
    }
  end

  def error_alert(msg)
    raw %{
    <div class="alert alert-error">
      <a class="close" data-dismiss="alert">×</a>
      #{msg}
    </div>
    }
  end
end

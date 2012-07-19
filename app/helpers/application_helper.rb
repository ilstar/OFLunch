# -*- encoding : utf-8 -*-
module ApplicationHelper
  def icon_helper(icon)
    content_tag(:i, :class => icon) 
  end

  def edit_icon_tag(msg = '编辑')
    raw("<i class='icon-edit icon-white'> </i>  #{msg}")
  end

  def delete_icon_tag(msg = '删除')
    raw("<i class='icon-remove icon-white'> </i>  #{msg}")
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

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

  def rating_summary_tag(rating, comment)
    title = (1..5).map do |i|
      if i <= rating.round
        image_tag "red_star.png", width: "14x14"
      else
        image_tag "white_star.png", width: "14x14"
      end
    end.join('') + " (#{rating})"

    link_to "javascript:;", rel: 'popover', data: {title: title.gsub('"', "'"), content: comment, trigger: 'hover'} do
      image_tag "comment.png", width: "12x12"
    end
  end

end

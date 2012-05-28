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

  def messages_content(messages)
    result = ''

    messages.each do |msg|
      result << (content_tag :li do
        message_content msg
      end)
    end

    raw result
  end

  def message_content(msg)
    if msg.entity_type == 'BalanceLog'
      raw "您的账户充值#{msg.entity.amount}元, #{link_to '点击查看', redirect_message_path(msg, redirect_to: bills_path), method: 'put'}"
    end
  end
end

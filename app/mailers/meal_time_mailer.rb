# -*- encoding : utf-8 -*-
class MealTimeMailer < ActionMailer::Base
  default from: "oflunch.notify@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.meal_time_mailer.close_reminder.subject
  #
  def close_reminder(recipient)
    @meal_time = MealTime.first

    mail to: recipient, subject: "[oflunch提醒]今日菜单尚未关闭"
  end
end

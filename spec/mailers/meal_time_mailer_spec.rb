# encoding: utf-8
require "spec_helper"

describe MealTimeMailer do
  describe "close_reminder" do
    before do
      FactoryGirl.create :meal_time

      @recipient =FactoryGirl.build :user
      @mail = MealTimeMailer.remind_to_close @recipient.email
    end

    it "renders the headers" do
      @mail.subject.should eq("[oflunch提醒]今日菜单尚未关闭")
      @mail.from.should eq(["oflunch.notify@gmail.com"])
      @mail.to.should eq([@recipient.email])
    end

    it "renders the body" do
      @mail.body.encoded.should match("关闭")
    end
  end

end

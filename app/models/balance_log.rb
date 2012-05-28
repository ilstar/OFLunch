# -*- encoding : utf-8 -*-

class BalanceLog < ActiveRecord::Base
  belongs_to :balance
  # has_many :messages, as: :entity

  validates_numericality_of :amount, :message => "金额必须是数字并且金额须小于10000", :less_than => 10000
  after_create :notify_user

  protected

  def notify_user
    msg = Message.create recipient_id: self.balance.user_id
    msg.update_attribute :content, "您的账户充值#{self.amount}元, <a href='/messages/#{msg.id}/redirect?redirect_to=%2Fbills' data-method='put'>点击查看</a>"
  end
end

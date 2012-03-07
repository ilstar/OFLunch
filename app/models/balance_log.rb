# -*- encoding : utf-8 -*-

class BalanceLog < ActiveRecord::Base
  belongs_to :balance
  validates_numericality_of :amount, :message => "金额必须是数字"
  validates_numericality_of :amount, :less_than => 10000, :message => "金额须小于10000", :allow_blank => true
end

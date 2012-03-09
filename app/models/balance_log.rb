# -*- encoding : utf-8 -*-

class BalanceLog < ActiveRecord::Base
  belongs_to :balance
  validates_numericality_of :amount, :message => "金额必须是数字并且金额须小于10000", :less_than => 10000
end

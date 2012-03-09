class Balance < ActiveRecord::Base
  belongs_to :user
  has_many :balance_logs, :dependent => :destroy

  def deduct(amount)
   self.amount -= amount 
   self.save!
  end

  #validate do |o|
  #  self.errors.add(:base, "") if o.user.email == "kevin.xu@gree.co.jp"
  #end
end

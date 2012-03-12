class Balance < ActiveRecord::Base
  belongs_to :user
  has_many :balance_logs, :dependent => :destroy

  def deduct(amount)
   self.amount -= amount 
   self.save!
  end

end

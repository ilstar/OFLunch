class Balance < ActiveRecord::Base
  belongs_to :user
  has_many :balance_logs, :dependent => :destroy
end

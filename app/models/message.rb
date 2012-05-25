class Message < ActiveRecord::Base
  attr_accessible :content, :recipient_id
  belongs_to :recipient, class_name: 'User'

  def read!
    self.read = true
    self.save
  end
end

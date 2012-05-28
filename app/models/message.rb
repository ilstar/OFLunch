class Message < ActiveRecord::Base
  attr_accessible :content, :recipient_id, :entity
  belongs_to :recipient, class_name: 'User'
  belongs_to :entity, polymorphic: true

  def read!
    self.read = true
    self.save
  end
end

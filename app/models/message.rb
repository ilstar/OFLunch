class Message < ActiveRecord::Base
  attr_accessible :content, :recipient_id
end

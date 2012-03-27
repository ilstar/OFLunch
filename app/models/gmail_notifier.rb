class GmailNotifier

  # send email via Gmail
  # 
  # GmailNotifier.notify :to => 'email@example.com', :subject => 'subject', :body => 'content'
  #
  # also support send to multi-recipients once
  # GmailNotifier.notify :to => ['email@example.com', 'email2@example.com'], :subject => 'subject', :body => 'content'
  #
  # the body support html format.
  def self.notify(hash = {})
    Gmail.connect ENV['OFLUNCH_GMAIL_USERNAME'], ENV['OFLUNCH_GMAIL_PASSWORD'] do |gmail|
      gmail.deliver do
        to hash[:to]
        subject hash[:subject]
        html_part do
          content_type "text/html; charset=UTF-8"
          body hash[:body]
        end
      end
    end
  end

end

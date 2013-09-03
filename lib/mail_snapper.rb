require 'gmail'

class MailSnapper
  def initialize (username='vpt.shopping.tracker', password='miss7581')
    @username = username
    @password = password
  end

  def get_tracking_info
    x = emails
    emails.each do |mail|
      puts mail.body
      puts '~~~~~~~~~~~~~~~'
    end
  end

  def emails
    @emails ||= begin
      Gmail.connect(@username, @password) do |gmail|
        # :all, :after, :before, :on, :from, :to, :subject, :label, :attachment, :search, :body, :query
        return gmail.inbox.emails(:subject => "track") || []
      end
    end
  end
end
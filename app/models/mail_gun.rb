class MailGun
  def self.create_mailbox(name)
    api_key = ENV["MG_API_KEY"]
    RestClient.post "https://api:key-#{api_key}@api.mailgun.net/v2/agilechamp.mailgun.org/mailboxes",
    :mailbox => "#{name}@agilechamp.mailgun.org",
    :password => ENV["MG_PWD"]
  end
  def self.delete_mailbox(name)
     api_key = ENV["MG_API_KEY"]
    RestClient.delete "https://api:key-#{api_key}@api.mailgun.net/v2/agilechamp.mailgun.org/mailboxes/#{name}"
  end
end
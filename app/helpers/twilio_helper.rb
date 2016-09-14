class TwilioService
  def self.client
    @client ||= Twilio::REST::Client.new(
      ENV["twilio_account_sid"], 
      ENV["twilio_auth_token"]
    )
  end
end

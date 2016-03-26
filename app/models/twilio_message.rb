class TwilioMessage < ActiveRecord::Base  
  def self.from_params(params)
    msg = self.new

    params.each do |k,v|
      msg.send("#{k.underscore}=", v)
    end
    
    msg
  end
  
  
  private
  
  KNOWN_KEYS = [
    'ToCountry',
    'ToState',
    'SmsMessageSid',
    'ToCity',
    'SmsSid',
    'FromState',
    'SmsStatus',
    'FromCity',
    'Body',
    'FromCountry',
    'To',
    'MessagingServiceSid',
    'MessageSid',
    'AccountSid',
    'From',
    'ApiVersion',
    'NumMedia',
    'FromZip',
    'ToZip',
    'NumSegments'
  ]
end

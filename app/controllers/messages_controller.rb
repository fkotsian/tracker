require 'twilio-ruby'
require './app/models/phone'
require './app/models/user'

class MessagesController < ApplicationController
  def respond
    message_sid = message_params['MessageSid']
    user_number = message_params['From']
    body = message_params['Body']

    user = User.joins(:phones).where(['number = ?', user_number]).first

    if !user
      user_phone = Phone.new(number: user_number)
      user = User.new(phones: [user_phone])
      user.save!

      twiml = Twilio::TwiML::Response.new do |r|
        r.Message welcome_message
      end 
    else
      p "User: #{user}"
      # load the user
      # check for previous message
    end
    
    render formats: :xml, body: twiml.text
  end

  private

  def welcome_message
    'Welcome to Trigger Mood! We help you be your best self by asking you about your mood once per day. Excited to have you!'
  end

  def message_params
    params.permit(
      [
        'MessageSid', 'SmsSid', 'AccountSid', 'MessagingServiceSid', 
        'From', 'To', 'Body', 
        'NumMedia', 'MediaContentType', 'MediaUrl',
        'FromCity', 'FromState', 'FromZip', 'FromCountry', 
        'ToCity', 'ToState', 'ToZip', 'ToCountry'
      ]
    )
  end
end

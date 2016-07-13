require 'twilio-ruby'
require './app/models/phone'
require './app/models/user'
require './app/models/subscriptions/mood_subscription'

class MessagesController < ApplicationController
  def respond
    message_sid = message_params['MessageSid']
    user_number = message_params['From']
    body = message_params['Body']

    user = User.joins(:phones).where(['number = ?', user_number]).first

    if !user
      user = User.new
      user_phone = Phone.new(number: user_number)
      user_subscription = MoodSubscription.new

      p user_subscription.subscription_configurations

      user_subscription.subscription_configurations << default_subscription_configuration
      user.phones << user_phone
      user.subscriptions << user_subscription
      user.save!



      twiml = Twilio::TwiML::Response.new do |r|
        r.Message welcome_message
        r.Message time_config_message
      end 
    else
      # load the user
      # check for previous message
    end
    
    render formats: :xml, body: twiml.text
  end

  private

  def welcome_message
    'Welcome to Trigger Mood! We help you be your best self by asking you about your mood once per day. Excited to have you!'
  end

  def time_config_message
    'We will text you about your mood up to three times per day. Send back up to three times you\'d like us to check in with you at. (Eg: 4am, 12:15pm, 6:30pm).'
  end

  def default_subscription_configuration
    SubscriptionConfiguration.new(time_to_send: '12:00')
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

require 'twilio-ruby'
require './app/models/phone'
require './app/models/user'
require './app/models/subscription_configuration'
require './app/models/subscriptions/mood_subscription'

class MessagesController < ApplicationController
  def respond
    session["pending_messages"] ||= []

    message_sid = message_params['MessageSid']
    user_number = message_params['From']
    body = message_params['Body']

    user = User.fetch_by_phone_number(user_number)

    if !user
      user = User.new
      user_phone = Phone.new(number: user_number)
      user_subscription = MoodSubscription.new
      user_subscription_configuration = default_subscription_configuration(user_subscription)

      user_subscription_configuration.save!
      user_subscription.save!

      user_phone.save!
      user.phones << user_phone

      user.subscriptions << user_subscription
      user.save!

      twiml = Twilio::TwiML::Response.new do |r|
        r.Message welcome_message
        r.Message time_config_message
        r.Message using_this_app_message
      end 

      session["pending_messages"] << "time_settings"
    else
      # if keyword, check for keyword
      # else, check for previous message
      if session["pending_messages"].any?
        case session["pending_messages"]
        when "time_settings"
          session["pending_messages"].delete(index_of("time_settings"))

        end
      end

      twiml = Twilio::TwiML::Response.new do |r|
      end
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

  def using_this_app_message
    'Respond STOP at any time to stop. You can check your mood data and some sweet graphs on your phone or the web at https://triggerapp.com/<your-phone-number>.'
  end

  def default_subscription_configuration(subscription)
    SubscriptionConfiguration.create!(time_to_send: '12:00', subscription: subscription)
  end

  def message_params
    params.require('body').permit(
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

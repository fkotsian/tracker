require 'twilio-ruby'

class MessagesController < ApplicationController
  def send_message

    Rails.logger.info "ENV: #{ENV}"

    
    @twilio_number = ENV['twilio_number']
    @client = new_client

    Rails.logger.info "Client: #{@client}"
    recipient = ENV['recipient_number']
    
    Rails.logger.info "Receiver: #{recipient}"
    
    message = @client.account.messages.create(
      from: @twilio_number,
      to: recipient,
      body: 'Hello from Twilio!'
    )
    
    Rails.logger.info "RECIPIENT: #{@twilio_number}"
    Rails.logger.info "SENT A MESSAGE TO: #{message.to}"
    
    render status: 200, json: {}
  end
  
  private
  
  def new_client
    Twilio::REST::Client.new(ENV['twilio_account_sid'], ENV['twilio_auth_token'])
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def twilio_client
    @client ||= Twilio::REST::Client.new ENV["twilio_account_sid"], ENV["twilio_auth_token"]
  end
end

require 'nokogiri'

class MessagesController < ApplicationController
  SUPPORTED_ACTIONS = {
    "'Log'"       => 'to record what you did today',
    "'Food'"      => 'to record what you ate today',
    "'Workout'"   => 'to record your workout today'
  }
  
  def respond
    m = TwilioMessage.from_params(filtered_params)

    body = filtered_params['Body']
    trigger = body.split(/\s/).first
    
    case trigger
    when /^(diary|log|journal)/i
      m.message_category = 'diary'
      m.save!
    when /^food/i
      m.message_category = 'food'
      m.save!
    when /^workout/i
      m.message_category = 'workout'
      m.save!
    else
      twiml = Nokogiri::XML::Builder.new(encoding:'UTF-8') do |xml|
        xml.Response {
          xml.Message <<-RESP
            I'm sorry, I didn't understand that.
Try #{SUPPORTED_ACTIONS.map{|a,d| "#{a} #{d}."}.join(" ") }
          RESP
        }
      end
    end
    
    twiml ||= Nokogiri::XML::Builder.new(encoding:'UTF-8') do |xml|
      xml.Response {
        xml.Message <<-RESP
          RECEIVED YOUR MESSAGE: #{trigger}. Thank you!
        RESP
      }
    end

    render status: 200, xml: twiml
  end
  
  def completion_callback
  end
  
  
  private
    
  def filtered_params
    params.permit(TwilioMessage::KNOWN_KEYS)
  end
  
end

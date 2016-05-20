require 'nokogiri'

class MessagesController < ApplicationController
  SUPPORTED_ACTIONS = {
    "'Log'"       => 'to record what you did today',
    "'Food'"      => 'to record what you ate today',
    "'Workout'"   => 'to record your workout today'
  }
  
  def diary
    body = filtered_params['Body'].strip
    if body.empty?
      twiml = could_not_understand
    else
      # saves diary message
      m = TwilioMessage.from_params(filtered_params)
      m.save!
    
      num_entries = TwilioMessage.where("created_at >= ?", beginning_of_week).count
      # sends autoresponse: "You've diaried X days this week. To see what you did this week, respond 'Journal'. To see your personal diary, go to <name>.tracker.cfapps.io."
    
      twiml ||= Nokogiri::XML::Builder.new(encoding:'UTF-8') do |xml|
        xml.Response {
          xml.Message <<-RESP
          You've journaled #{num_entries} days this week. Send "Journal" anytime to see your recent entries, or visit tracker.cfapps.com/your_name.
          RESP
        }
      end
      
      render status: 200, xml: twiml
    end
  end
  
  def record
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
      twiml = could_not_understand
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
  
  def beginning_of_week
    (Date.today.wday + 1).days.ago.beginning_of_day
  end
  
  def could_not_understand
    Nokogiri::XML::Builder.new(encoding:'UTF-8') do |xml|
      xml.Response {
        xml.Message <<-RESP
          I'm sorry, I didn't understand that.
Try #{SUPPORTED_ACTIONS.map{|a,d| "#{a} #{d}."}.join(" ") }
        RESP
      }
    end
  end
    
end

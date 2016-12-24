require 'twilio-ruby'
require './app/helpers/twilio_helper'

namespace :messages do
  desc 'Send a message checking in on mood'
  task :send_mood => :environment do
    to_number = '+13104835624'
    TwilioHelper.client.messages.create({
      from: '+16508894472',
      to: to_number,
      body: 'How is your mood right now, from 1 to 5?'
    })

    Rails.logger.info("RAKE: Sent mood message to #{to_number}")

    # session["pending_messages"] << "mood"
  end

  desc "Ask whether user went to the gym today"
  task :ask_if_gym => :environment do
    already_went = GymResponse.where('created_at > ?', Date.today.to_time.utc).count >= 1

    unless already_went
      msg = "Hey Frank! Have you gone to the gym today? Respond 'Gym' to record."
      to_number = '+13104835624'

      TwilioHelper.client.messages.create({
        from: '+16508894472',
        to: to_number,
        body: msg
      })

      Rails.logger.info("RAKE: Asked for gym status from #{to_number}")
    end
  end

  desc 'Send a message summarizing gym activity for the week'
  task :send_gym_summary => :environment do
    return unless Date.today.wday == 6  # only run on Saturday; hack to get around Heroku Scheduler

    gym_accounts = GymResponse.where('created_at > ?', 1.week.ago).count

    case gym_accounts
    when -> (accounts) { accounts >= 3 }
      msg = "Congrats! You visited the gym #{gym_accounts} times this week! Think about how many weeks it's going to take to get that 6-pack. :swole:!"
    else
      msg = "Aw cman! You visited the gym #{gym_accounts} times this week. You can do better than that! What are you going to do differently next week?"
    end

    to_number = '+13104835624'
    TwilioHelper.client.messages.create({
      from: '+16508894472',
      to: to_number,
      body: msg
    })

    Rails.logger.info("RAKE: Sent gym summary message to #{to_number}")
  end
end

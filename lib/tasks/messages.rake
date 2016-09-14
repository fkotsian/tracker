require 'twilio-ruby'
require './app/helpers/twilio_helper'

namespace :messages do
  desc 'Send a message checking in on mood'
  task :send_mood do
    to_number = '+13104835624'
    TwilioHelper.client.messages.create({
      from: '+16508894472',
      to: to_number,
      body: 'How is your mood right now, from 1 to 5?'
    })

    Rails.logger.info("RAKE: Sent mood message to #{to_number}")

    # session["pending_messages"] << "mood"
  end
end

require 'twilio-ruby'
require './app/helpers/twilio_helper'

namespace :messages do
  desc 'Send a message checking in on mood'
  task :send_mood do
    TwilioHelper.client.messages.create({
      from: '+16508894472',
      to: '+13104835624',
      body: 'How is your mood right now, from 1 to 5?'
    })

    session["pending_messages"] << "mood"
  end
end

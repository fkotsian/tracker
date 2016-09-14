require 'spec_helper'
require './app/controllers/messages_controller'
require 'database_cleaner'

describe MessagesController do
  DatabaseCleaner.strategy = :transaction

  before(:each) do
    DatabaseCleaner.start
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  context 'when an incoming message comes in', type: :controller do
    context 'and the user is new' do
      it 'subscribes the user to the service' do
        expect(MoodSubscription).to receive(:new).and_call_original
        expect_any_instance_of(MoodSubscription).to receive(:save!)

        post_message
      end

      it 'sets up a default time setting' do
        expect(SubscriptionConfiguration).to receive(:create!).with(time_to_send: '12:00', 
                                                                    subscription: anything)  # ideally in UTC
          .and_call_original

        post_message
      end
      
      it 'responds with a welcome message' do
        post_message
        
        expect(response.body).to include(  
          'Welcome to Trigger Mood! We help you be your best self by asking you about your mood once per day. Excited to have you!'
        )
      end

      it 'informs the user how to stop and how to check their data on the web' do
        post_message
        
        expect(response.body).to include(  
          'Respond STOP at any time to stop. You can check your mood data and some sweet graphs on your phone or the web at https://triggerapp.com/&lt;your-phone-number&gt;.'
        )
      end

      context 'asking for time settings' do
        it 'asks for the desired times to receive messages' do
          post_message

          expect(response.body).to include(  
            'We will text you about your mood up to three times per day. Send back up to three times you\'d like us to check in with you at. (Eg: 4am, 12:15pm, 6:30pm).'
          )
        end

        it 'sets a cookie tracking the time settings in the response' do
          post_message

          expect(session["pending_messages"]).to include("time_settings")
        end
      end
    end

    context 'and the user is not new' do
      let(:user) { User.create! }
      let!(:phone) { Phone.create!(number: '1234', user: user) }

      it 'loads the user from the database via the phone number' do
        expect(User).to receive(:fetch_by_phone_number).with('1234').and_return(user)

        post_message('some-message')
      end

      context 'when messages are waiting for response' do
        context 'when configuring time settings' do
          before do
            session["pending_messages"] << "time_settings"
          end

          it 'saves the time settings to the users subscription' do
            expect(SubscriptionConfiguration)
            
            post_message('8 12:00 1pm')
          end
          it 'expires the cookie, showing that the response has been received'
          it 'saves the message, user, time, and location in the database'
        end

        context 'when waiting for a mood response' do
          before do
            session["pending_messages"] << "mood"
          end

          it 'saves the mood'
          it 'expires the cookie, showing that the response has been received'
          it 'saves the message, user, time, and location in the database'
        end
      end

      context 'when the message is a keyword' do
        context 'STOP'
        context 'LINK - link to the web' # also be called DATA
        context 'HELP'                   # also be called CONFIG or MENU
        context 'other stuff'
      end
    end
  end

  def post_message(body='Sign me up!')
    post :respond, body: { 'From': '1234', 'MessageSid': 'abcd', 'body': body }
  end
end

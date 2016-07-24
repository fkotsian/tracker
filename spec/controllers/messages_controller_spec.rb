require 'spec_helper'
require './app/controllers/messages_controller'

describe MessagesController do
  context 'when an incoming message comes in', type: :controller do
    context 'and the user is new' do
      it 'responds with a welcome message' do
        post :respond, body: { 'From': '1234', 'MessageSid': 'abcd', 'body': 'Sign me up!' }
        
        expect(response.body).to include(  
          'Welcome to Trigger Mood! We help you be your best self by asking you about your mood once per day. Excited to have you!'
        )
      end

      it 'subscribes the user to the service' do
        expect(MoodSubscription).to receive(:new).and_call_original
        expect_any_instance_of(MoodSubscription).to receive(:save!)

        post :respond, body: { 'From': '1234', 'MessageSid': 'abcd', 'body': 'Sign me up!' }
      end

      it 'sets up a default time setting' do
        expect(SubscriptionConfiguration).to receive(:create!).with(time_to_send: '12:00', 
                                                                    subscription: anything)  # ideally in UTC
          .and_call_original

        post :respond, body: { 'From': '1234', 'MessageSid': 'abcd', 'body': 'Sign me up!' }
      end

      context 'asking for time settings' do
        xit 'asks for the desired times to receive messages' do
          post :respond, body: { 'From': '1234', 'MessageSid': 'abcd', 'body': 'Sign me up!' }

          expect(response.body).to include(  
            'We will text you about your mood up to three times per day. Send back up to three times you\'d like us to check in with you at. (Eg: 4am, 12:15pm, 6:30pm).'
          )
        end

        xit 'sets a "time-settings" cookie in the response' do
        end
      end
    end

    context 'and the user is not new' do
      xit 'loads the user from the database via the phone number' do
      end

      context 'when configuring time settings' do
        it 'saves the time settings'
        it 'expires the cookie, showing that the response has been received'
      end

      xit 'informs the user how to stop and how to check their data on the web' 

      context 'when the message is a keyword' do
        context 'STOP'
        context 'LINK - link to the web'
        context 'other stuff'
      end

      context 'when the message is a response to a previous message' do
        context 'and a message cookie exists' do
          xit 'saves the message, user, time, and location in the database' do
            fail
          end
        end
      end
    end
  end
end

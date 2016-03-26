class CreateTwilioMessages < ActiveRecord::Migration
  def change
    create_table :twilio_messages do |t|
      t.string :to_country
      t.string :to_state
      t.string :sms_message_sid
      t.integer :num_media
      t.string :to_city
      t.integer :from_zip
      t.string :sms_sid
      t.string :from_state
      t.string :sms_status
      t.string :from_city
      t.string :body
      t.string :from_country
      t.string :to
      t.string :messaging_service_sid
      t.integer :to_zip
      t.integer :num_segments
      t.string :message_sid
      t.string :account_sid
      t.string :from
      t.string :api_version

      t.timestamps null: false
    end
  end
end

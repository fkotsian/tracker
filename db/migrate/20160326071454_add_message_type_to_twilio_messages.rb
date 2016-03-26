class AddMessageTypeToTwilioMessages < ActiveRecord::Migration
  def change
    add_column :twilio_messages, :message_category, :string
  end
end

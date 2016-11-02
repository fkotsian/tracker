class Response < ActiveRecord::Base
  belongs_to :user

  attr_reader :body
  attr_reader :type

  def response_body
    response_text + " " + response_data_tag
  end

  def response_text
    "Thanks! I've received your message. Have a great day!"
  end

  def response_data_tag
    "View your data at trigger-app.heroku.com."
  end

end

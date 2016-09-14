class Response < ActiveRecord::Base
  belongs_to :user

  attr_reader :body
  attr_reader :type
end

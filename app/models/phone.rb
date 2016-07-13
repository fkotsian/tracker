class Phone < ActiveRecord::Base
  belongs_to :user
  attr_reader :number
end

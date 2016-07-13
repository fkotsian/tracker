class User < ActiveRecord::Base
  has_many :phones 
  has_many :subscriptions
  has_many :subscription_configurations, through: :subscriptions
end

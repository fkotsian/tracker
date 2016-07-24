class User < ActiveRecord::Base
  has_many :phones 
  has_many :subscriptions
  has_many :subscription_configurations, through: :subscriptions

  def self.fetch_by_phone_number(number)
    User.joins(:phones).where(['number = ?', number]).first
  end
end

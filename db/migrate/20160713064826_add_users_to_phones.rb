class AddUsersToPhones < ActiveRecord::Migration
  def change
    add_reference :phones, :user, index: true, foreign_key: true
  end
end

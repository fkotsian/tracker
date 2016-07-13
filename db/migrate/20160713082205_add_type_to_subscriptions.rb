class AddTypeToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :type, :string
  end
end

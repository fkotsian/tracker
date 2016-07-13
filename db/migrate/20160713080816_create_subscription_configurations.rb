class CreateSubscriptionConfigurations < ActiveRecord::Migration
  def change
    create_table :subscription_configurations do |t|
      t.references :subscription, index: true, foreign_key: true
      t.time :time_to_send

      t.timestamps null: false
    end
  end
end

class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :body
    end
  end
end

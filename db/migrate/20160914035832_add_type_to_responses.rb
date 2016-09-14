class AddTypeToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :type, :string, index: true
  end
end

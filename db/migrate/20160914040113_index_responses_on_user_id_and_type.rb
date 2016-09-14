class IndexResponsesOnUserIdAndType < ActiveRecord::Migration
  def change
    add_index :responses, [:user_id, :type]
  end
end

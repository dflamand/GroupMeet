class AddGroupIndexToUser < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :group_id
  end
end

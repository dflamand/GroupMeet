class CreateUserGroupJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :groups_users, :id => false do |t|
    t.integer :group_id
    t.integer :user_id
    end
  add_index :groups_users, [:group_id, :user_id]
  end
  
end

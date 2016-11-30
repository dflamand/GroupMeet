class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end

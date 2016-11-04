class UserForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :group_id, :integer
    add_foreign_key :users, :groups
  end
end

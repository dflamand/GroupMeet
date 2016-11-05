class GroupOwner < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :groupowner, :integer
  end
end

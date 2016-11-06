class AllowNilGroup < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :group_id, :integer, allow_nil: true
  end
end

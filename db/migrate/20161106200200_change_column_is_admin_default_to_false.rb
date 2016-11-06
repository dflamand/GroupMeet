class ChangeColumnIsAdminDefaultToFalse < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :isAdmin, :boolean, :default => false
  end
end

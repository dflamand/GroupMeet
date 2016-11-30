class AddGnameToInvite < ActiveRecord::Migration[5.0]
  def change
    add_column(:invites, :gname, :string)
  end
end

class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :firstName
      t.string :lastName
      t.boolean :isAdmin

      t.timestamps
    end
  end
end

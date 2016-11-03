class CreateGroups < ActiveRecord::Migration[5.0]
  has_many :locations
  def change
    create_table :groups do |t|
      t.string :gname
      
      t.timestamps
    end
  end
end

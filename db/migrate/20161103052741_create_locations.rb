class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :group_id
      
      t.decimal :longitude, :precision => 10, :scale => 6 
      t.decimal :latitude, :precision => 10, :scale => 6 
      t.string :address
      t.timestamps
    end
    add_index(:locations, :group_id)
  end
end

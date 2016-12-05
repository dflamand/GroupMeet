class AddTransportationModeToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :tMode, :string
  end
end

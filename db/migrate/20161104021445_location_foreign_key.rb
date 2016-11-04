class LocationForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :locations, :groups
  end
end

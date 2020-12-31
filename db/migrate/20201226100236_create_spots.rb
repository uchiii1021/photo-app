class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :photo, null: false, foreign_key: true

      t.timestamps
    end
  end
end

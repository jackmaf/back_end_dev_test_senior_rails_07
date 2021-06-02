class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips do |t|
      t.references :rider, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.string :lat_ini
      t.string :lng_ini
      t.string :lat_end
      t.string :lng_end
      t.integer :distance_km
      t.integer :minutes
      t.integer :base_fee
      t.integer :total_fee

      t.timestamps
    end
  end
end

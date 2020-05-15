class CreateParkingSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :parking_spots do |t|
      t.integer :user_id
      t.integer :spot_id
      t.integer :vehicle_id
      t.datetime :start
      t.datetime :end
      t.integer :amount
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end

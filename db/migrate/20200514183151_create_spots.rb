class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string :name
      t.float :lat
      t.float :lng
      t.string :address
      t.integer :count, default: 1
      t.string :description
      t.datetime :open
      t.datetime :close

      t.timestamps
    end
  end
end

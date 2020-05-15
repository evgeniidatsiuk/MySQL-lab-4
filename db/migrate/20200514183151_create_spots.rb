class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :address
      t.integer :count, default: 1
      t.string :description
      t.boolean :is_open, default: true

      t.timestamps
    end
  end
end

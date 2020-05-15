class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.boolean :gender
      t.string :phone

      t.timestamps
    end
  end
end

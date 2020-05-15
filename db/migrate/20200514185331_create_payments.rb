class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.integer :spot_id
      t.integer :user_id

      t.timestamps
    end
  end
end

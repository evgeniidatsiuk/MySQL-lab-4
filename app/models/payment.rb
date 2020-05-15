class Payment < ApplicationRecord
    # belongs_to :user
    # belongs_to :spot

    # тригер перевіряє на пристутнутність об'єктів по user_id & spot_id
    before_save :find_references
    # після успішної оплати - оновити статус парковочного місця на - paid(true)
    after_create :update_parking_spot

    def find_references
      user = User.find_by_sql("SELECT users.* FROM users WHERE id = #{self.user_id} LIMIT 1")
      spot = Spot.find_by_sql("SELECT spots.* FROM spots WHERE id = #{self.spot_id} LIMIT 1")

      if spot == []
        raise "Spot with id: #{self.spot_id} not found"
      end

      if user == []
        raise "User with id: #{self.user_id} not found"
      end
    end

    def update_parking_spot
      sql = "UPDATE spots SET paid = true WHERE id = #{self.spot_id} LIMIT 1"
      ActiveRecord::Base.connection.execute(sql)
    end
end

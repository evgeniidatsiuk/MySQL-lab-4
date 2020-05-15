class ParkingSpot < ApplicationRecord
  # тригер перевіряє на пристутнутність об'єктів по user_id & spot_id  & vehicle_id
  before_save :find_references
  # тригер який рахує суму за весь час паркування (скільки потрібно заплатити користувачу за години які він вказав)
  before_save :calculate_amount
  # тригер який після паркування на парковку зменшує кількість доступних місць в парковці
  before_create :update_spot

  # метод перевіряє на пристутнутність об'єктів по user_id & spot_id & vehicle_id
  # якшо нема - повернути помилку
  def find_references
    user = User.find_by_sql("SELECT users.* FROM users WHERE id = #{self.user_id} LIMIT 1")
    spot = Spot.find_by_sql("SELECT spots.* FROM spots WHERE id = #{self.spot_id} LIMIT 1")
    vehicle = Vehicle.find_by_sql("SELECT vehicles.* FROM vehicles WHERE id = #{self.vehicle_id} LIMIT 1")

    if spot == []
      raise "Spot with id: #{self.spot_id} not found"
    end

    if user == []
      raise "User with id: #{self.user_id} not found"
    end

    if vehicle == []
      raise "Vehicle with id: #{self.vehicle_id} not found"
    end
  end
  # метод який рахує суму за весь час паркування (скільки потрібно заплатити користувачу за години які він вказав)
  def calculate_amount
    spot = Spot.find_by_sql("SELECT spots.* FROM spots WHERE id = #{self.spot_id} LIMIT 1").first
    hours = (self.end - self.start).to_i / 3600
    self.amount = hours * spot.price_per_hour
  end

  # метод який після паркування на парковку зменшує кількість доступних місць в парковці
  def update_spot
    spot = Spot.find_by_sql("SELECT spots.* FROM spots WHERE id = #{self.spot_id} LIMIT 1").first
    sql = "UPDATE spots SET count = count - 1 WHERE id = #{self.spot_id} LIMIT 1"

    # якщо немає місць - неможна припаркуватися
    if spot.present? && spot.count < 1
      raise "You cannot park here because count < 1"
    end

    # якщо закрито - неможна припаркуватися
    if spot.is_open == false
      raise "You cannot park here because is_open false"
    end

    ActiveRecord::Base.connection.execute(sql)
  end


end

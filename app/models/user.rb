class User < ApplicationRecord
  # тригер який перевіряє на валідність даних перед збереженням у базу даних
  before_save :check
  # тригер який після успішного створення користувача стоврює профіль для цього користувача
  after_commit :create_profile, on: :create
  # тригер який після успішного видалення користувача з бази даних видалить також всі об'єкти де є користувач
  after_destroy :delete_all

  # метод який перевіряє на валідність даних якщо щось не так то виведе помилку
  def check
    if self.email == nil
      raise 'Email cannot be empty'
    end

    if self.password == nil
      raise 'Password cannot be empty'
    end
  end

  # метод який створює профіль для користувача
  def create_profile
    sql = "INSERT INTO `profiles` (`user_id`, `created_at`, `updated_at`) VALUES (#{self.id}, '#{Time.zone.now.to_datetime}', '#{Time.zone.now.to_datetime}')"
    ActiveRecord::Base.connection.execute(sql)
  end

  # метод який видаляє всі об'єкти де є користувач
  def delete_all
    queries = []
    queries << "DELETE FROM parking_spots WHERE user_id = #{self.id}"
    queries << "DELETE FROM profiles WHERE user_id = #{self.id} LIMIT 1"
    queries << "DELETE FROM payments WHERE user_id = #{self.id}"
    queries << "DELETE FROM vehicles WHERE user_id = #{self.id}"
    queries.each { |sql|  ActiveRecord::Base.connection.execute(sql) }
  end
end

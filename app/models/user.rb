class User < ApplicationRecord
  # has_one :profile

  before_save :check
  after_commit :create_profile, on: :create
  after_destroy :delete_all

  def check
    if self.email == nil
      raise 'Email cannot be empty'
    end

    if self.password == nil
      raise 'Password cannot be empty'
    end
  end

  def create_profile
    sql = "INSERT INTO `profiles` (`user_id`, `created_at`, `updated_at`) VALUES (#{self.id}, '#{Time.zone.now.to_datetime}', '#{Time.zone.now.to_datetime}')"
    ActiveRecord::Base.connection.execute(sql)
  end

  def delete_all
    queries = []
    queries << "DELETE FROM parking_spots WHERE user_id = #{self.id}"
    queries << "DELETE FROM profiles WHERE user_id = #{self.id} LIMIT 1"
    queries << "DELETE FROM payments WHERE user_id = #{self.id}"
    queries.each { |sql|  ActiveRecord::Base.connection.execute(sql) }
  end
end

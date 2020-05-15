# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Spot.create [
#   {
#     name: 'name',
#
#
#   }
# ]

#створити юзера
sql = "INSERT INTO `users` (`email`, `password`, `created_at`, `updated_at`) VALUES ('x@x.x', 'password', '#{Time.zone.now.to_datetime}', '#{Time.zone.now.to_datetime}')"
ActiveRecord::Base.connection.execute(sql)

sql = "SELECT  `profiles`.* FROM `profiles` WHERE `profiles`.`user_id` = #{id} LIMIT 1"
# створити парковки
15.times do |name|
  sql = "INSERT INTO `spots` (`name`, `address`, `count`, `description`, `open`, `close`, `created_at`, `updated_at`) VALUES ('name - #{name}', 'Університетська #{name}', #{rand(10)}, 'Паркуйся, не бійся', '2020-05-14 19:35:59', '2020-05-15 03:35:59', '2020-05-14 19:35:59', '2020-05-14 19:35:59')"
  ActiveRecord::Base.connection.execute(sql)
end


sql = "SELECT  `spots`.* FROM `spots` WHERE `spots`.`open` >= '#{Time.zone.now.to_datetime}' AND `spots`.`close` <= '#{Time.zone.now.to_datetime}'"
Spot.find_by_sql(sql)

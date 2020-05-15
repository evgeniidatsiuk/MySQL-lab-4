#створити юзера
sql = "INSERT INTO `users` (`email`, `password`, `created_at`, `updated_at`) VALUES ('x@x.x', 'password', '#{Time.zone.now.to_datetime}', '#{Time.zone.now.to_datetime}')"
ActiveRecord::Base.connection.execute(sql)

# створити парковки
15.times do |name|
  sql = "INSERT INTO `spots` (`name`, `address`, `count`, `description`, `is_open`, `created_at`, `updated_at`) VALUES ('name - #{name+1}', 'Університетська #{name+1}', #{rand(10)}, 'Паркуйся, не бійся', #{name % 2 == 0}, '2020-05-14 19:35:59', '2020-05-14 19:35:59')"
  ActiveRecord::Base.connection.execute(sql)
end


# sql = "SELECT  `spots`.* FROM `spots` WHERE `spots`.`open` >= '#{Time.zone.now.to_datetime}' AND `spots`.`close` <= '#{Time.zone.now.to_datetime}'"

# отримати достуні парковочні місця
Spot.find_by_sql("SELECT spots.* FROM spots WHERE is_open = true AND count >= 1")

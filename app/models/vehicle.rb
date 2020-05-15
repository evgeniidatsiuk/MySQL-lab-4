class Vehicle < ApplicationRecord
  
  # тригер який перевіряє на валідність даних перед збереженням у базу даних
  before_save :check

  # метод який перевіряє на валідність даних якщо щось не так то виведе помилку
  def check
    if self.email == nil
      raise 'Email cannot be empty'
    end

    if self.password == nil
      raise 'Password cannot be empty'
    end
  end
end

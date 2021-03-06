class Spot < ApplicationRecord
  # тригер який перевіряє на валідність даних перед збереженням у базу даних
  before_save :check

  # метод який перевіряє на валідність даних якщо щось не так то виведе помилку
  def check
    if self.name == nil
      raise 'Name cannot be empty'
    end

    if self.address == nil
      raise 'Address cannot be empty'
    end

    if self.count < 1
      raise 'COUNT cannot be < 1'
    end
  end
end

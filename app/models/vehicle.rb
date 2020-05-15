class Vehicle < ApplicationRecord
  belongs_to :user

  # тригер який перевіряє на валідність даних перед збереженням у базу даних
  before_save :check

  # метод який перевіряє на валідність даних якщо щось не так то виведе помилку
  def check
    if self.name == nil
      raise 'Name cannot be empty'
    end

    if self.number == nil
      raise 'Number cannot be empty'
    end
  end
end

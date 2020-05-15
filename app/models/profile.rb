class Profile < ApplicationRecord
  # тригер який перевіряє при оновленні на валідність даних перед збереженням у базу даних
  # чому при оновленні? Бо при створенні користувач отримує пустий профіль - там ми його не валідуємо
  before_save :check, on: :update

  # метод який перевіряє на валідність даних якщо щось не так то виведе помилку
  def check
    if self.first_name == nil
      raise 'First name cannot be empty'
    end

    if self.last_name == nil
      raise 'Last name cannot be empty'
    end

    if self.age < 5
      raise 'Age cannot be < 5'
    end

    if self.phone == nil
      raise 'Phone cannot be empty'
    end

    if self.email == nil
      raise 'Email cannot be empty'
    end
  end

end

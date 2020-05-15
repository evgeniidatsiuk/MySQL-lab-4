class Profile < ApplicationRecord
  # belongs_to :user

  before_save :check, on: :update


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

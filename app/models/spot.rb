class Spot < ApplicationRecord
  before_save :check


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

class Spot < ApplicationRecord
  before_save :check


  def check
    if self.name == nil
      raise 'Name cannot be empty'
    end
  end
end

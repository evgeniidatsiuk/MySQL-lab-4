class Payment < ApplicationRecord
    # belongs_to :user
    # belongs_to :spot

    before_save :check

    def check
      if self.amount < 100
        raise 'Amount cannot be < 100'
      end
    end
end

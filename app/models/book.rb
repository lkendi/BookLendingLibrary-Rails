class Book < ApplicationRecord
    has_many :borrowings

    def available?
        borrowings.where(returned_at: nil).none?
    end
end

class Book < ApplicationRecord
    has_many :borrowings, dependent: :destroy

    validates :title, :author, :isbn, presence: { message: " cannot be blank." }
    validates :isbn, uniqueness: { message: " already exists." }
    validates :isbn, format: { with: /\A(\d{10}|\d{13})\z/, message: " must be either 10 or 13 digits." }

    def available?
        borrowings.where(returned_at: nil).none?
    end

    def borrow_by!(user)
        with_lock do
            raise ActiveRecord::RecordInvalid unless available?
            borrowings.create!(
            user: user,
            borrowed_at: Time.current,
            due_date: 2.weeks.from_now
        )
        end
    end
end

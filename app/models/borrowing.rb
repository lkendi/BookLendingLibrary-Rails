class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validate :book_availability, on: :create
  validates :borrowed_at, presence: true
  validates :user, presence: true
  validates :book, presence: true

  private
  def book_availability
    return if book.nil? || book.available?
    errors.add(:book, "is not available for borrowing")
  end
end

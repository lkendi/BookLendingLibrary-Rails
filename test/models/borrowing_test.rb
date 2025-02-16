require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  def setup
    @user = users(:two)
    @book = books(:two)
    @borrowing = Borrowing.new(user: @user, book: @book, borrowed_at: Time.current, due_date: 2.weeks.from_now)
  end

  test "should be valid with valid associations" do
    assert @borrowing.valid?,
      "Borrowing invalid: #{@borrowing.errors.full_messages.to_sentence}"
  end

  test "should belong to a user" do
    assert_equal @user, @borrowing.user
  end

  test "should belong to a book" do
    assert_equal @book, @borrowing.book
  end
end

require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email_address: "testuser@example.com", password: "password", role: "user")
    @book = Book.create!(title: "Test Book", author: "Test Author", isbn: "1234567890")
    @borrowing = Borrowing.new(user: @user, book: @book, borrowed_at: Time.current)
  end

  test "should be valid with valid associations" do
    assert @borrowing.valid?
  end

  test "should belong to a user" do
    assert_equal @user, @borrowing.user
  end

  test "should belong to a book" do
    assert_equal @book, @borrowing.book
  end
end

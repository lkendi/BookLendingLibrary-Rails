require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    unique_isbn = Array.new([ 10, 13 ].sample) { rand(10) }.join
    @book = Book.new(title: "Test Book", author: "Test Author", isbn: unique_isbn)
    @user = User.create!(email_address: "user@example.com", password: "password")
  end

  test "should be valid with valid attributes" do
    assert @book.valid?
  end

  test "should be invalid without title" do
    @book.title = nil
    assert_not @book.valid?
    assert_includes @book.errors[:title], " cannot be blank."
  end

  test "should be invalid without author" do
    @book.author = nil
    assert_not @book.valid?
    assert_includes @book.errors[:author], " cannot be blank."
  end

  test "should be invalid without isbn" do
    @book.isbn = nil
    assert_not @book.valid?
    assert_includes @book.errors[:isbn], " cannot be blank."
  end

  test "should be invalid with improperly formatted isbn" do
    @book.isbn = "123"
    assert_not @book.valid?
    assert_includes @book.errors[:isbn], " must be either 10 or 13 digits."
  end

  test "should be invalid with duplicate isbn" do
    duplicate_book = @book.dup
    @book.save!
    assert_not duplicate_book.valid?
    assert_includes duplicate_book.errors[:isbn], " already exists."
  end

  test "available? returns true when there are no active borrowings" do
    @book.save!
    assert @book.available?
  end

  test "available? returns false when there is an active borrowing" do
    @book.save!
    user = User.create!(email_address: "test@example.com", password: "password", role: "user")
    @book.borrowings.create!(user: user, borrowed_at: Time.current, returned_at: nil)
    assert_not @book.available?
  end

  test "available? returns true when all borrowings have been returned" do
    @book.save!
    user = User.create!(email_address: "another@example.com", password: "password", role: "user")
    @book.borrowings.create!(user: user, borrowed_at: Time.current, returned_at: Time.current)
    assert @book.available?
  end

  test "book is available when no active borrowings" do
    assert @book.available?, "Book should be available if there are no active borrowings"
  end

  test "book is not available when there is an active borrowing" do
    Borrowing.create!(user: @user, book: @book, borrowed_at: Time.current)
    assert_not @book.available?, "Book should not be available if there is an active borrowing"
  end

  test "borrow_by! raises error when book is not available" do
    Borrowing.create!(user: @user, book: @book, borrowed_at: Time.current)
    assert_raises(ActiveRecord::RecordInvalid) do
      @book.borrow_by!(@user)
    end
  end
end

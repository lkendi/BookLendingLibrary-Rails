require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email_address: "user@example.com", password: "password")
    @book = Book.create!(title: "Sample Book", author: "Author", isbn: "1234567898")

    post session_url, params: { email_address: @user.email_address, password: @user.password }
  end

  test "should get index" do
    borrowing = Borrowing.create!(user: @user, book: @book, borrowed_at: Time.current)
    get borrowings_url
    assert_response :success
    assert_includes assigns(:borrowings), borrowing
  end

  test "should create borrowing with available book" do
    assert_difference("Borrowing.count") do
      post borrowings_url, params: { book_id: @book.id }
    end
    assert_redirected_to books_path
    assert_equal "You have successfully borrowed the book.", flash[:notice]
  end

  test "should not create borrowing with unavailable book" do
    Borrowing.create!(user: @user, book: @book, borrowed_at: Time.current)
    post borrowings_url, params: { book_id: @book.id }
    assert_redirected_to books_path
    assert_equal "This book is currently unavailable.", flash[:alert]
  end

  test "should return book" do
    borrowing = Borrowing.create!(user: @user, book: @book, borrowed_at: Time.current)
    delete borrowing_url(borrowing)
    borrowing.reload
    assert_not_nil borrowing.returned_at
    assert_redirected_to borrowings_path
    assert_equal "Book returned successfully.", flash[:notice]
  end

  test "should not return another user's borrowing" do
    other_user = User.create!(email_address: "other@example.com", password: "password")
    borrowing = Borrowing.create!(user: other_user, book: @book, borrowed_at: Time.current)

    post session_url, params: { email_address: @user.email_address, password: @user.password }

    delete borrowing_url(borrowing)

    borrowing.reload
    assert_nil borrowing.returned_at, "Borrowing should not be marked as returned"
  end
end

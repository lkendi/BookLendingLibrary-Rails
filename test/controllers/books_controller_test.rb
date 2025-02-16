require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email_address: "user@example.com", password: "password")
    @book1 = Book.create!(title: "Ruby Programming", author: "Author One", isbn: "0987654321")
    @book2 = Book.create!(title: "Rails Guide", author: "Author Two", isbn: "1010101010101")

    post session_url, params: { email_address: @user.email_address, password: @user.password }
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should search books" do
    get books_url, params: { search: "ruby" }
    assert_response :success
    assert_match "Ruby Programming", @response.body
    assert_no_match "Rails Guide", @response.body
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    assert_difference("Book.count", 1) do
      post books_url, params: { book: { title: "New Book", author: "Author", isbn: "9876543210" } }
    end
    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    get book_url(@book1)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book1)
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book2), params: { book: { author: "Updated Author", isbn: "0101010101010", title: "Updated Title" } }
    assert_redirected_to book_url(@book2)
  end

  test "should destroy book" do
    assert_difference("Book.count", -1) do
      delete book_url(@book2)
    end
    assert_redirected_to books_url
  end
end

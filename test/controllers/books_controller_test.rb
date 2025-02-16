require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regular_user = User.create!(
      email_address: "user@example.com",
      password: "password",
      role: 1
    )

    @admin_user = User.create!(
      email_address: "admin@example.com",
      password: "adminpassword",
      role: 0
    )
    @book1 = Book.create!(title: "Ruby Programming", author: "Author One", isbn: "0987654321")
    @book2 = Book.create!(title: "Rails Guide", author: "Author Two", isbn: "1010101010101")

    post session_url, params: { email_address: @regular_user.email_address, password: @regular_user.password }
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

  test "should redirect non-admins from admin actions" do
    post session_url, params: { email_address: @regular_user.email_address, password: @regular_user.password }

    get new_book_url
    assert_redirected_to root_path

    post books_url, params: { book: { title: "New Book" } }
    assert_redirected_to root_path

    get book_url(@book1)
    assert_redirected_to root_path
  end

   test "admin should access admin actions" do
    post session_url, params: { email_address: @admin_user.email_address, password: @admin_user.password }

    get new_book_url
    assert_response :success

    assert_difference("Book.count", 1) do
      post books_url, params: { book: {
        title: "New Book",
        author: "Author",
        isbn: "9876543210"
      } }
    end
    assert_redirected_to book_url(Book.last)

    get book_url(@book1)
    assert_response :success

    get edit_book_url(@book1)
    assert_response :success

    patch book_url(@book2), params: { book: {
      author: "Updated Author",
      isbn: "0101010101010",
      title: "Updated Title"
    } }
    assert_redirected_to book_url(@book2)

    assert_difference("Book.count", -1) do
      delete book_url(@book2)
    end
    assert_redirected_to books_url
  end
  test "unauthorized user cannot access new book" do
    get new_book_url
    assert_redirected_to root_path
  end

  test "unauthorized user cannot create book" do
    assert_no_difference("Book.count") do
      post books_url, params: { book: { title: "New Book" } }
    end
    assert_redirected_to root_path
  end

  test "admin can delete book" do
    post session_url, params: { email_address: @admin_user.email_address, password: @admin_user.password }

    assert_difference("Book.count", -1) do
      delete book_url(@book1)
    end
  end
end

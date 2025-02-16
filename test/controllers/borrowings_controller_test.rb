require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @book = books(:one)
    Current.user = @user
  end

  teardown do
    Current.user = nil
  end

  test "should get index" do
    get borrowings_url
    assert_response :success
  end

  test "should create borrowing when book is available" do
    @book.borrowings.update_all(returned_at: Time.current)
    assert_difference("Borrowing.count") do
      post borrowings_url, params: { book_id: @book.id }
    end
    assert_redirected_to books_url
  end

  test "should not create borrowing when book is unavailable" do
    Borrowing.create!(user: @user, book: @book, borrowed_at: Time.current, returned_at: nil)
    assert_no_difference("Borrowing.count") do
      post borrowings_url, params: { book_id: @book.id }
    end
    assert_redirected_to books_url
  end

  test "should destroy borrowing (return book)" do
    borrowing = Borrowing.create!(user: @user, book: @book, borrowed_at: Time.current, returned_at: nil)
    assert_no_difference("Borrowing.count") do
      delete borrowing_url(borrowing)
    end
    borrowing.reload
    assert_not_nil borrowing.returned_at
    assert_redirected_to borrowings_url
  end
end

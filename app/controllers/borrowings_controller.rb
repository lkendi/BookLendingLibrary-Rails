class BorrowingsController < ApplicationController
  def index
    @borrowings = Current.user.borrowings.includes(:book).page(params[:page]).per(10)
  end


  def create
    @book = Book.find(params[:book_id])
    @book.borrow_by!(Current.user)
    redirect_to books_path, notice: "Book borrowed successfully."
  rescue ActiveRecord::RecordInvalid
    redirect_to books_path, alert: "Book unavailable or already borrowed."
  rescue ActiveRecord::RecordNotFound
    redirect_to books_path, alert: "Book not found."
  end


  def destroy
    borrowing = Borrowing.find(params[:id])
    if borrowing.user == Current.session.user
      borrowing.update!(returned_at: Time.current)
      redirect_to borrowings_path, notice: "Book returned successfully."
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end

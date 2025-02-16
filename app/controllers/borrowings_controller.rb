class BorrowingsController < ApplicationController
  def index
    @borrowings = Current.user.borrowings.includes(:book).order(borrowed_at: :desc)
end


  def create
    Book.transaction do
    @book = Book.lock.find(params[:book_id])
    if @book.available?
      @borrowing = Current.user.borrowings.build(
          book: @book,
          borrowed_at: Time.current,
          due_date: 2.weeks.from_now
        )
      if @borrowing.save
          redirect_to books_path, notice: "Book borrowed successfully."
      else
          redirect_to books_path, alert: @borrowing.errors.full_messages.to_sentence
      end
    else
        redirect_to books_path, alert: "This book is currently unavailable."
    end
    end
    rescue ActiveRecord::RecordNotFound
    redirect_to books_path, alert: "Book not found"
  rescue ActiveRecord::StaleObjectError
    redirect_to books_path, alert: "Book availability changed. Please try again."
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

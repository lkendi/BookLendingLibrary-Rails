class BorrowingsController < ApplicationController
  def index
    @borrowings = Current.user.borrowings.includes(:book)
  end

  def create
    @book = Book.find(params[:book_id])
    if @book.available?
      @borrowing = Current.user.borrowings.build(book: @book, borrowed_at: Time.current)
      if @borrowing.save
        redirect_to books_path, notice: "You have successfully borrowed the book."
      else
        redirect_to books_path, alert: @borrowing.errors.full_messages.to_sentence
      end
    else
      redirect_to books_path, alert: "This book is currently unavailable."
    end
  end

  def destroy
    @borrowing = Current.user.borrowings.find(params[:id])
    @borrowing.update(returned_at: Time.current)
    redirect_to borrowings_path, notice: "Book returned successfully."
  end
end

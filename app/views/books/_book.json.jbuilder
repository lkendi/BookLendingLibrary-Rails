json.extract! book, :id, :title, :author, :isbn, :status, :created_at, :updated_at
json.url book_url(book, format: :json)

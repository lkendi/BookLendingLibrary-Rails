class AddUniqueIndexToBorrowings < ActiveRecord::Migration[8.0]
  def change
    add_index :borrowings, :book_id, unique: true, where: "returned_at IS NULL", name: "index_borrowings_on_book_id_unreturned"
  end
end

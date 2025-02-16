class AddBorrowedAtToBorrowings < ActiveRecord::Migration[8.0]
  def change
    add_column :borrowings, :borrowed_at, :datetime
  end
end

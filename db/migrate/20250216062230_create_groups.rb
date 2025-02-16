class CreateGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :borrowing, null: false, foreign_key: true

      t.timestamps
    end
  end
end

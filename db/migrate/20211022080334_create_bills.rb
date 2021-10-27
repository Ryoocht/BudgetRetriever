class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.integer :user_id, foreign_key: true
      t.integer :month_id, foreign_key: true
      t.integer :year
      t.float :price
      t.text :detail
      t.integer :category_id, foreign_key: true
      t.integer :subcategory_id, foreign_key: true
      t.integer :further_subcategory_id, foreign_key: true

      t.timestamps
    end
  end
end

class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.integer :month_id
      t.integer :year
      t.float :price
      t.text :detail
      t.bigint :category_id, foreign_key: true

      t.timestamps
    end
  end
end

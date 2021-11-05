class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :month, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.integer :year
      t.float :price
      t.text :detail
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
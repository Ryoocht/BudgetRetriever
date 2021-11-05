class CreateUsersBills < ActiveRecord::Migration[6.1]
  def change
    create_table :users_bills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
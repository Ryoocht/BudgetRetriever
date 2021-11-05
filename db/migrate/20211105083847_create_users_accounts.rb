class CreateUsersAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :users_accounts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true

      t.timestamps
    end
  end
end

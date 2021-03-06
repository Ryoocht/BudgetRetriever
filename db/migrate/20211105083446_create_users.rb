class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest

      t.string :uid
      t.string :email
      t.string :image
      
      t.string :google_token
      t.string :google_refresh_token


      t.timestamps
    end
  end
end
class User < ApplicationRecord
    has_many :users_accounts
    has_many :accounts, through: :users_accounts
    has_many :users_bills
    has_many :bills, through: :users_bills
    
    has_secure_password
end
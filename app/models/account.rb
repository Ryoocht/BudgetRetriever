class Account < ApplicationRecord
    has_many :users_accounts
    has_many :users, through: :users_accounts
    has_many :bills
end
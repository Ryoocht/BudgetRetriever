class Account < ApplicationRecord
    has_many :users_accounts
    has_many :users, through: :users_accounts
    has_many :bills
    
    # validates :name, presence: true, uniqueness: true
end
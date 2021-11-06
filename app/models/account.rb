class Account < ApplicationRecord
    has_many :users_accounts
    has_many :users, through: :users_accounts, dependent: :destroy
    has_many :bills
    has_many :categories, through: :bills, dependent: :destroy
    
    # validates :name, presence: true, uniqueness: true
end
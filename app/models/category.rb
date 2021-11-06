class Category < ApplicationRecord
    has_many :bills
    has_many :accounts, through: :bills, dependent: :destroy
    has_ancestry

end

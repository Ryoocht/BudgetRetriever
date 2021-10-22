class Category < ApplicationRecord
    has_many :bills
    has_ancestry
end

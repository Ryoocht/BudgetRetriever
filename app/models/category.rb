class Category < ApplicationRecord
    has_many :bills
    has_many :accounts, through: :bills, dependent: :destroy
    has_ancestry

    def total_category_values(category)
        
    end

end

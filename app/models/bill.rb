class Bill < ApplicationRecord
    belongs_to :account
    belongs_to :category
    belongs_to :month

    has_many :users_bills
    has_many :users, through: :users_bills, dependent: :destroy

    # validates_presence_of :user, :month, :account, :year, :price, :detail, :category, :subcategoryid, :further_subcategoryid
    # validates :price, numericality: {greater_than_or_equal_to: 0}
    # validates :year, numericality: {less_than_or_equal_to: 2050}
    # validates :category, exclusion: { in: %w(Select Category), message: "Please Select Category from the options"}
    # validates :detail, length: { in: 1..30 }

    # total table scopes
    scope :main_category_scope, -> (category, month) {
        total = "price) FROM bills WHERE category_id = #{category} AND month_id = #{month};"
        if total != nil
            calculate(:sum, total)
        end
    }

    scope :subcategory_scope, -> (category, month) {
        total = "price) FROM bills WHERE subcategoryid = #{category} AND month_id = #{month};"
        if total != nil
            calculate(:sum, total)
        end
    }

    scope :further_subcategory_scope, -> (category, month) {
        total = "price) FROM bills WHERE further_subcategoryid = #{category} AND month_id = #{month};"
        if total != nil
            calculate(:sum, total)
        end
    }
end

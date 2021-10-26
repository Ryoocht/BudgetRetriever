class Bill < ApplicationRecord
    belongs_to :category
    belongs_to :month

    accepts_nested_attributes_for :category

    validates_presence_of :year, :price
    validates_associated :category, :month
end

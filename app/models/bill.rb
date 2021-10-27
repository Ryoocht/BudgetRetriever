class Bill < ApplicationRecord
    belongs_to :category
    belongs_to :month

    accepts_nested_attributes_for :month, reject_if: proc {|attributes| attributes['name'].blank?}

    # validates_presence_of :year, :price
    # validates_associated :category, :month
end

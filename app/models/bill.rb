class Bill < ApplicationRecord
    belongs_to :category
    belongs_to :month
end

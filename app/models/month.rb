class Month < ApplicationRecord
    has_many :bills

    validates :month, exclusion: { in: %w(---),message: "Select a month" }
end
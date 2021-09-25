class Record < ApplicationRecord
  validates :amount, presence: true
  validates :category, presence: true
end

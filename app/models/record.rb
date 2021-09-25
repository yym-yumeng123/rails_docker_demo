class Record < ApplicationRecord
  enum category: {  outgoings: 1, income: 2 }
  
  validates :amount, presence: true
  validates :category, presence: true
end

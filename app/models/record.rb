class Record < ApplicationRecord
  # 我拥有很多从属, taggings
  has_many :taggings
  # 因为每一个 tagging 又属于某一个 tag, 所以 rcord 拥有很多 tags,  通过 taggings
  has_many :tags, through: :taggings

  belongs_to :user

  enum category: {  outgoings: 1, income: 2 }
  
  validates :amount, presence: true
  validates :category, presence: true
end

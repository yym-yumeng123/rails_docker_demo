class Tagging < ApplicationRecord
  # 记录从属关系, 即属于record, 又属于tag

  # 属于record, 所以需要在 record 中 set 
  belongs_to :record, required: true
  belongs_to :tag, required: true

  belongs_to :user
end

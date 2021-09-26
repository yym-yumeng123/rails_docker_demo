require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'create' do
    it 'name must presence' do
      tag = Tag.create 
      p tag.errors

      expect(tag.errors.details[:name][0][:error]).to eq(:blank)
      expect(tag.errors[:name][0]).to eq('标签名不能为空')
    end
  end
end

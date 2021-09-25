require 'rails_helper'

RSpec.describe Record, type: :model do
  it 'amount must presence' do
    record = Record.create category: 'outgoings', notes: 'xxx'
    expect(record.errors.details[:amount][0][:error]).to eq(:blank)
  end

  it 'category must presence' do
    record = Record.create amount: 10000, notes: 'xxx'
    expect(record.errors.details[:category][0][:error]).to eq(:blank)
  end
end

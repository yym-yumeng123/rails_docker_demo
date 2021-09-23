require 'rails_helper'

RSpec.describe User, type: :model do
  it 'create user' do
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(user.password_digest).to_not eq '123456'
    expect(user.id).to be_a Numeric
  end

  it 'delete user' do
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect { User.destroy_by id: user.id }.to change { User.count }.from(1).to(0)
  end
end

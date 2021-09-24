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

  # 测试 user.rb 里面的内容
  it 'password must presence' do
    user = User.create password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to eq(:blank)
  end

  it 'email nust uniqueness' do
    User.create! email: '1@qq.com', password: '123456', password_confirmation: '123456'
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to eq(:taken)
  end

  xit 'email must send mailer' do
    mailer = spy ('mailer')
    allow(UserMailer).to receive(:welcome_email).and_return(mailer)
    User.create! email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(UserMailer).to have_received(:welcome_email)
    expect(mailer).to have_received(:deliver_later)
    
  end

  it 'if email empty string only tips empty' do
    user = User.create email: ''
    expect(user.errors.details[:email].length).to eq 1
    expect(user.errors.details[:email][0][:error]).to eq :blank
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'create user' do
    user = create(:user)
    expect(user.password_digest).to_not eq '123456'
    expect(user.id).to be_a Numeric
  end

  xit 'delete user' do
    user = create(:user)
    expect { User.destroy_by id: user.id }.to change { User.count }.from(3).to(2)
  end

  # 测试 user.rb 里面的内容
  it 'password must presence' do
    user = User.create password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to eq(:blank)
  end

  it 'email nust uniqueness' do
    create :user, email: '1@qq.com'
    user = build :user, email: '1@qq.com'
    user.validate
    expect(user.errors.details[:email][0][:error]).to eq(:taken)
  end

  xit 'email must send mailer' do
    mailer = spy ('mailer')
    allow(UserMailer).to receive(:welcome_email).and_return(mailer)
    create(:user)
    expect(UserMailer).to have_received(:welcome_email)
    expect(mailer).to have_received(:deliver_later)
    
  end

  it 'if email empty string only tips empty' do
    user = User.create email: ''
    expect(user.errors.details[:email].length).to eq 1
    expect(user.errors.details[:email][0][:error]).to eq :blank
  end
end

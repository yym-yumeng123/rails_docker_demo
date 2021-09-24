require 'rails_helper'

RSpec.describe "Users", type: :request do
  it 'create user' do
    post "/users", params: {email: ''}
    expect(response.status).to eq 422
    body = JSON.parse(response.body)
    expect(body["errors"]["email"][0]).to eq '邮箱不能为空'
    expect(body["errors"]["email"].length).to eq 1
    expect(body["errors"]["password"][0]).to eq '密码不能为空'
    expect(body["errors"]["password"].length).to eq 1
    expect(body["errors"]["password_confirmation"][0]).to eq '确认密码不能为空'
    expect(body["errors"]["password_confirmation"].length).to eq 1
  end

  it 'should not get user info' do
    # not login
    get '/user_info'
    expect(response).to have_http_status :not_found
    expect(response.body.blank?).to be true
  end

  it 'should get user info' do
    # 创建用户
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    # 登录
    post "/sessions", params: {email: '1@qq.com', password: '123456'}
    get '/user_info'
    body = JSON.parse(response.body)
    expect(response).to have_http_status :ok
    expect(body['resources']['id']).to eq user.id
  end
end

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do
  post "/users" do
    parameter :email, '邮箱', type: :string, required: true
    parameter :password, '密码', type: :string, required: true
    parameter :password_confirmation, '再次确认', type: :string, required: true
    example "创建文档(注册)" do
      request = {
          email: '1@qq.com',
          password: '123456',
          password_confirmation: '123456'
      }
      do_request(request)

      expect(status).to eq 200
    end
  end
end

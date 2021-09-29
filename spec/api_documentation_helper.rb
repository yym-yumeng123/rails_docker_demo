# 修改文档的 Headers
require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.configure do |config|
  config.before(:each) do |spec|
    if spec.metadata[:type].equal? :acceptance
      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
    end
  end
end

# 扩展
module RspecApiDocumentation::DSL
  module Endpoint
    def sign_in(user = nil)
      user ||= create :user
      # 不生成文档
      no_doc do
        client.post '/sessions', {email: user.email, password: user.password}
      end
      user # return user
    end
  end
end
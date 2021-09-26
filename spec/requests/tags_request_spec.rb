require 'rails_helper'

RSpec.describe "Tags", type: :request do
  context 'create' do
    it 'should not create tag before login' do
      post '/tags', params: {name: '吃饭'}
      expect(response.status).to eq 401
  
    end
    it 'create tag' do
      sign_in
      # 存钱按照货币最小值计算  分 ==> 100 块 ==> 10000 分
      post '/tags', params: {name: '吃饭'}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['resources']['id']).to be
    end
  
    it 'should not create tag without name' do
      sign_in
      post '/tags'
      expect(response.status).to eq 422
      body = JSON.parse(response.body)
      expect(body['errors']['name'][0]).to eq '标签名不能为空'
    end
  end
end

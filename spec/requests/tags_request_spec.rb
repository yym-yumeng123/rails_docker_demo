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

  
  context 'destory' do
    it 'should not destory a tag before sign in' do
      tag = Tag.create! name: 'xxx'
      delete "/tags/#{tag.id}"
      expect(response.status).to be 401
    end

    it 'should destory a tag' do
      sign_in
      tag = Tag.create! name: 'xxx'
      delete "/tags/#{tag.id}"
      expect(response.status).to be 200
    end
  end

  context 'index' do
    it 'should not get tags before sign in' do
      get '/tags'
      expect(response.status).to be 401
    end

    it 'should get tags after sign in' do
      (1..11).to_a.map do |n|
        Tag.create! name: "#{n}"
      end
      sign_in
      get '/tags'
      expect(response.status).to be 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end

  context 'show' do
    it 'should not get a tag before sign in' do
      tag = Tag.create! name: 'xxx'
      get "/tags/#{tag.id}"
      expect(response.status).to be 401
    end
    it 'should get a tag after sign in' do
      sign_in
      tag = Tag.create! name: 'xxx'
      get "/tags/#{tag.id}"
      expect(response.status).to be 200
    end
    it 'should not get a tag because not fount' do
      sign_in
      get "/tags/999999999999999999"
      expect(response.status).to be 404
    end
  end

  context 'update' do
    it 'should not update a tag before sign in' do
      tag = Tag.create! name: 'xxxxx'
      patch "/tags/#{tag.id}", params: {name: 'yyyy'}
      expect(response.status).to eq 401
    end

    it 'should update a tag' do
      sign_in
      tag = Tag.create! name: 'xxxxx'
      patch "/tags/#{tag.id}", params: {name: 'yyyy'}
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body["resources"]["name"]).to eq 'yyyy'
    end
  end
end

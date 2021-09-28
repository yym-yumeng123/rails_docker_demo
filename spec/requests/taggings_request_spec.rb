require 'rails_helper'

RSpec.describe "Taggings", type: :request do
  context 'create' do
    it 'should not create tagging before login' do
      post '/taggings'
      expect(response.status).to eq 401
    end
    it 'should create tagging after login' do
      sign_in
      tag = Tag.create! name: 'test'
      record = Record.create! amount: 10000, category: 'income'
      post '/taggings', params: {record_id: record.id, tag_id: tag.id}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['resources']['id']).to be
    end
  
    it 'should not create tagging without record_id' do
      sign_in
      tag = Tag.create! name: 'test'
      post '/taggings', params: {tag_id: tag.id}
      expect(response.status).to eq 422
      body = JSON.parse(response.body)
      expect(body['errors']['record'][0]).to eq '记录不能为空'
    end
  end
end

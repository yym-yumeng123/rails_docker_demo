require 'rails_helper'

RSpec.describe "Records", type: :request do
  before :each do
    @user = create(:user)
  end
  context 'create' do
    it 'should not create record before login' do
      post '/records', params: {amount: 10000, category: 'outgoings', notes: '猪脚饭', user: @user}
      expect(response.status).to eq 401
  
    end
    it 'create records' do
      sign_in
      # 存钱按照货币最小值计算  分 ==> 100 块 ==> 10000 分
      post '/records', params: {amount: 10000, category: 'outgoings', notes: '猪脚饭', user: @user}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['resources']['id']).to be
    end
  
    it 'should not create records' do
      sign_in
      post '/records', params: { category: 'outgoings', notes: '猪脚饭', user: @user}
      expect(response.status).to eq 422
      body = JSON.parse(response.body)
      expect(body['errors']['amount'][0]).to eq '金额不能为空'
    end
  end

  context 'destory' do
    it 'should not destory a record before sign in' do
      record = create :record
      delete "/records/#{record.id}"
      expect(response.status).to be 401
    end

    it 'should destory a record' do
      sign_in
      record = create :record
      delete "/records/#{record.id}"
      expect(response.status).to be 200
    end
  end

  context 'index' do
    it 'should not get records before sign in' do
      get '/records'
      expect(response.status).to be 401
    end

    it 'should get records after sign in' do
      (1..11).to_a.map do
        create :record
      end
      sign_in
      get '/records'
      expect(response.status).to be 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end

  context 'show' do
    it 'should not get a record before sign in' do
      record = create :record
      get "/records/#{record.id}"
      expect(response.status).to be 401
    end
    it 'should get a record after sign in' do
      sign_in
      record = create :record
      get "/records/#{record.id}"
      expect(response.status).to be 200
    end
    it 'should not get a record because not fount' do
      sign_in
      get "/records/999999999999999999"
      expect(response.status).to be 404
    end
  end

  context 'update' do
    it 'should not update a record before sign in' do
      record = create :record
      patch "/records/#{record.id}", params: {amount: 9900}
      expect(response.status).to eq 401
    end

    it 'should update a record' do
      sign_in
      record = create :record
      patch "/records/#{record.id}", params: {amount: 9900}
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body["resources"]["amount"]).to eq 9900
    end
  end
end

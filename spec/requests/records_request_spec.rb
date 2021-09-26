require 'rails_helper'

RSpec.describe "Records", type: :request do
  it 'should not create record before login' do
    post '/records', params: {amount: 10000, category: 'outgoings', notes: '猪脚饭'}
    expect(response.status).to eq 401

  end
  it 'create records' do
    sign_in
    # 存钱按照货币最小值计算  分 ==> 100 块 ==> 10000 分
    post '/records', params: {amount: 10000, category: 'outgoings', notes: '猪脚饭'}
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body['resources']['id']).to be
  end

  it 'should not create records' do
    sign_in
    post '/records', params: { category: 'outgoings', notes: '猪脚饭'}
    expect(response.status).to eq 422
    body = JSON.parse(response.body)
    expect(body['errors']['amount'][0]).to eq '金额不能为空'
  end
end
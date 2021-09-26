require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Records" do
  let(:record){Record.create! amount: 10000, category: 'income'}
  let(:id){record.id}
  post "/records" do
    parameter :amount, '金额', type: :integer, required: true
    parameter :category, '类型 1: outgoings | 2: income', type: :integer, required: true
    parameter :notes, '备注', type: :string
    example "创建记录" do
      sign_in
      request = {
        amount: 10000,
        category: 'outgoings',
        notes: '123456'
      }
      do_request(request)

      expect(status).to eq 200
    end
  end

  delete "/records/:id" do
    example "删除记录" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  get "/records" do
    parameter :page, '页码', type: :integer

    let(:page) {1}
    example '获取所有记录' do
      (1..11).to_a.map do
        Record.create! amount: 10000, category: 'income'
      end
      sign_in
      do_request
      expect(status).to eq 200
    end

  end

  get "/records/:id" do
    example '获取一个的记录' do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end
end

Rails.application.routes.draw do
  # 学习渲染 文本 & json & html
  get '/hello', to: 'first#hello'
  get '/word', to: 'first#word'
  get '/json', to: 'first#json'
  get '/html', to: 'first#view'
end

Rails.application.routes.draw do
  # 学习渲染 文本 & json & html
  get '/hello', to: 'first#hello'
  get '/word', to: 'first#word'
  get '/json', to: 'first#json'
  get '/html', to: 'first#view'
  
  # 注册用户
  resources :users
  # 会话登录
  resources :sessions, only: [:create]
  # 获取当前用户信
  get '/user_info', to: 'users#info'

  # 注销用户
  delete '/sessions', to: 'sessions#destroy'
end

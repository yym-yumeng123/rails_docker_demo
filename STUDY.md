## MVC 架构

- 路由(Router)根据请求路径来选择控制器(Controller)
- 控制器选择合适的视图(View), 渲染给用户
- 如果涉及到数据库, 控制器会调用 Model 拿数据
- Model 会调用 ORM 来简化数据操作
- ORM 会直接与数据库打交道
- Rails 的 ActiveRecord 是一个超级强大的 ORM

## Rails 的依赖 -- Rack

- 提供非常简单的 API
- 封装了 HTTP request 和 HTTP response
- 提出了中间件模型

## gem

- `gem install` 后面添加 `--verbose(可以查看打印的东西)`
- 类似于 Node.js 里的 npm
- 局部安装可以用 `bundle install`

```bash
# 镜像
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/

bundle config mirror.https://rubygems.org https://gems.ruby-china.com
```

## Rails 创建

```bash
rails new projectName --database=postgresql --skip-action-mailbox --skip...
# --skip 跳过  --database 数据库
```

- `bin/rails s` 开启服务,会默认寻找数据库

```bash
# docker 安装数据库
docker run -v projectName-data:/var/lib/postgresql/data -p 5001:5432 -e POSTGRES_USER=fang -e POSTGRES_PASSWORD=123456 -d postgres:12.2
```

- projectName-data 是数据库目录名，可以替换为任意目录名，也可以替换为绝对路径
- 5001 是数据库服务端口名，可以随意替换，但要确保 database.yml 也作对应修改
- POSTGRES_USER=fang 是用户名，可以随意替换，但要确保 database.yml 也作对应修改
- POSTGRES_PASSWORD=123456 是密码，可以随意替换，但要确保 database.yml 也作对应修改

## 错误

- `FATAL: database "projectName_development" does not exist`

```bash
# 创建数据库
bin/rails db:create
# 把已经存在的数据库删除
bin/rails db:drop
```

## 运行 server

```
bin/rails s
```

## 修改文件, 自动刷新

- `windows 用户`

```bash
# development.rb
config.file_watcher = ActiveSupport::EventedFileUpdateChecker

# Gemfile
group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen'
  gem 'wdm', '>= 0.1.0', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
end
```

## HTML 继承

- `app/views` 可以创建 html, 里面 HTML 公用内容会默认继承 `application.html.erb` 里面的内容

## 使用命令行查看数据库

```bash
# 查看运行的容器
docker ps
# 进入开启的容器
docker exec -it 容器id bash
# 进入 postgresql 数据路
psql -U 用户名
# 链接数据看  \c 你得数据库名
\c projectName_development
# \dt  display table 查看所有的表
\dt

# 查看某一个 表
select * from users;
```

# bin/rails console

```bash
# 可以进入rails 控制台,可以操作创建好的类
# 例如 User , 创建sql 语句
u = User.new
u.email = 'xxx'
u.password_digest = 'xxx'
u.save
```

# rails has_secure_passsword ==> 保存密文方案

```bash
# 1.
gem 'bcrypt', '~> 3.1.7'
# 2. model 中 添加
has_secure_password
```

- `model` 模型主要和数据库交互

# Controller & 路由

```rb
Rails.application.routes.draw do
  # 获取 users 的 所有数据
  get '/users', to: 'users#index'
  # 获取 users 的 单个数据
  get '/users/:id', to: 'users#show'
  # 创建 users
  post 'users', to: 'users#create'
  # 删除
  delete 'users:id', to: 'users#destroy'
  # 更新
  patch 'users/:id', to: 'users#update'
end

Rails.application.routes.draw do
  # 代表上面所有的路由
  resources :users
end
```

```bash
# 查看所有路由
bin/rails routes

# ==>
    users GET    /users(.:format)        users#index
      user GET    /users/:id(.:format)    users#show
          POST   /users(.:format)        users#create
          DELETE /users/:id(.:format)    users#destroy
          PATCH  /users/:id(.:format)    users#update
          PUT    /users/:id(.:format)    users#update
  new_user GET    /users/new(.:format)    users#new
edit_user GET    /users/:id/edit(.:format)      users#edit
```

- 创建的路由用来控制 Controller

```bash
bin/rails g controller users
```

- 在 `controller` 下的文件做对应路由的操作

```rb
# 示例
class UsersController < ApplicationController
  # 可以处理 用户从 web端 的 ajax 请求
  # 对应路由的 create
  def create

  end
end
```

# 数据验证在 model
[validates](https://guides.rubyonrails.org/active_record_validations.html)

- `validates_presence_of` ==> 一直存在
  ```rb
  # emial 永远存在
  validates_presence_of :email
  ```
- `validates_format_of` ==> 验证格式
  ```rb
  # 验证 email 格式
  validates_format_of :email, with: /.+@.+/
  ```
- `validates_length_of` ==> 验证数据长短
  ```rb
  # 验证密码长短
  validates_length_of :password, :minimum=>6
  ```

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

# 删除某个表数据
delete from users;
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


# 国际化 I18n
```rb
# 1. 创建
# config/initializers/locale.rb

# 应用可用的区域设置白名单 英文 和中文
I18n.available_locales = [:en, "zh-CN"]

# 修改默认区域设置（默认是 :en） 设置为中文
I18n.default_locale = "zh-CN"
```

```yml
# 2. 创建 zh-CN.yml
# 根据错误路径来显示
zh-CN:
  activerecord:
    errors:
      models:
        user:
          attributes:
            password:
              blank: 密码不能为空
              too_short: 密码不能少于 6 个字符
            email:
              blank: 邮箱不能为空
              invalid: 邮箱不合法  
            password_confirmation:
              blank: 确认密码不能为空
```

# user.controller.rb 优化
```rb
# 初始
def
  user = User.new
  user.email = params[:email]
  user.password = params[:password]
  user.password_confirmation = params[:password_confirmation]
end
# 优化
def create
  #:email 表示一个简短的字符串 or symbol
  user = User.new({email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation]})
end
# 再次优化
def create
  # params.permit
  user = User.new(params.permit(:email, :password_confirmation, :password))
end

# 优化提取函数
def create_params
  # rails 可以省略 return
  params.permit(:email, :password_confirmation, :password)
end

# 使用函数 rails 可以省略括号
def create
  # params.permit
  user = User.new create_params
end

#-----------------------

# 优化 render json 部分
# 初始
if user.save
  render json: {resources: user}, status: 200
else
  render json: {errors: user.errors}, status: 400
end

# 优化 ==> 把 user.save 提取出来
user.save
if user.valid?
  render json: {resources: user}, status: 200
else
  render json: {errors: user.errors}, status: 400
end

# 提取函数
# 返回结果处理
def render_resources resource
  # 可以把结果包装一下
  if resource.valid?
    render json: {resources: resource}, status: 200
  else
    render json: {errors: resource.errors}, status: 400
  end
end

# render_resources 是所有controlleer 都能用的
# application_controller.rb
class ApplicationController < ActionController::API
  # 返回结果处理
  def render_resources(resource)
    # 可以把结果包装一下
    if resource.valid?
      render json: {resources: resource}, status: 200
    else
      render json: {errors: resource.errors}, status: 400
    end
  end
end
```
```rb
def create
  # new 和 save 继续优化
  user = User.new create_params
  user.save
  render_resources user
end

# ==>

def create
  user = User.create create_params
  render_resources user
end

# ==>
def create
  render_resources User.create create_params
end
```

# 邮箱注册后, 发送邮件
- 参考 [邮箱使用指南](https://rails-guides.upgradecoder.com/action_mailer_basics.html)
   - 2. 发送邮件
   - 6. 配置 `Action Mailer`

```rb
# qq 邮箱配置
# 账户开启 smtp 服务
config.action_mailer.delivery_method = :smtp
config.action_mailer.raise_delivery_errors = true
config.action_mailer.perform_caching = false
config.action_mailer.smtp_settings = {
    address: ENV['smtp_domain'],
    port: ENV['smtp_port'],
    domain: ENV['smtp_domain'],
    user_name: ENV['smtp_username'],
    password: ENV['smtp_password'],
    authentication: ENV['smtp_authentication'],
    enable_starttls_auto: ENV['smtp_enable_starttls_auto']
}
config.action_mailer.preview_path = "#{Rails.root}/spsc/mailers/previews"
```

# dotenv-rails github ==> 保护env 的内容

# ActiveRecord & ActiveModel
- `ActiveRecord` 就是 rails 封装的 `ORM` ==> 数据库里的记录
- User 继承 ActiveRecord, 因此 User 是数据库里的表, user 是记录
- `ActiveModel` 是轻量的 `ActiveRecord`, 不存在数据库, 其他都一样
# 登录 session
- 是不需要数据库的, 不需要每次登录记录到数据库

```bash
bin/rails g controller sessions 
```

# ActiveModel 无法使用 create
```rb
class SessionsController < ApplicationController
  def create_params
    params.permit(:email, :password)
  end

  def create
    # 我们添加, 但不放入 数据库 new & new 不会触发验证
    render_resources Session.new create_params
  end

  def destroy
  
  end
end

# ==>
class SessionsController < ApplicationController
  def create_params
    params.permit(:email, :password)
  end

  def create
    s = Session.new create_params
    # 触发验证
    s.validate
    render_resources s
  end

  def destroy
  
  end
end
```

# 自定义校验
```rb
class Session
  # 1. validate 不加s, 自定义校验
  validate :check_email, if: :email

  # 2. 定义
  def check_email
    user = User.find_by email: email
    # 如果 user 为 空
    if user.nil?
      # 3. errors.add
      errors.add :email, :not_found
    end
  end
end
```

# 用 session 记录用户登录状态
- 如果 `rails api` 模式, 则没有 session, 可以添加中间件
```rb
session[:current_user_id] = id
```
- `attr_accessor` 做了什么? 三件事
```rb
# 解决 session model 里的 bug

# attr_accessor :xxx,
# 1 声明一个对象的属性 @xxx
# 2. 声明一个方法 def xxx ==> 获取 @xxx 的值
# 3. def xxx = 赋值给 @xxx
```
- 在`application.rb` 配置

```rb
# set cookie 的key
config.session_store :cookie_store, key: '_morney_session_id'
```

# 记住密码怎么做?
1. 用户选择记住密码 ==> 传给 server 端
2. server 端返回一个 `随机数(数据库, 过期时间)` 给 `user(带有随机数)`
3. 当 user 再次访问, 登录过期了, 但有一个随机数
4. server 端查看这个随机数是否是之前给的随机数, 并且未过期
   ```
   session[:current_user_id] = 随机数.user.id
   ```
5. 如何设计这个数据库呢?
   - `user` 表加两个字段 `login_token 随机数`, `login_token_expired_at 过期时间`
   - 这会出现一个问题: 在不同设备之间登录, 会出现覆盖的问题
   - 或者可以设计一个 `user_login_data 表`, 存放不同设备的 


# 所有请求都需要登录后
1. 在需要登录的地方 => 方法 must_sign_in
2. 在 `application_controller.rb` 定义 `must_sign_in` `raise error`
3. `rescue_from error` 捕获 error, 调用方法
```rb
# 所有接口都要用到, application_controller.rb
# :: 说明当前命名空间下的 类

# 捕获错误
rescue_from CustomError::MustSignInError, with: :render_must_sign_in
def must_sign_in
  # 如果当前用户为空
  if current_user.nil?
    raise CustomError::MustSignInError
  end
end
def render_must_sign_in
  render status: :unauthorized
end


# 自己定义一个错误的类 lib/custom_error.rb
# 自定义error
module CustomError
  class MustSignInError < StandardError
  end
end
```
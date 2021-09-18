## MVC架构
- 路由(Router)根据请求路径来选择控制器(Controller)
- 控制器选择合适的视图(View), 渲染给用户
- 如果涉及到数据库, 控制器会调用Model拿数据
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
- `app/views` 可以创建 html, 里面HTML 公用内容会默认继承 `application.html.erb` 里面的内容

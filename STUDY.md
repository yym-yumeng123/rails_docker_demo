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
# 如何使用 Rspec

- [rspec github文档](https://github.com/rspec/rspec-rails)

- `model测什么` ==>  validation 和 public 方法
- `controller测什么` ==> 测 响应体 和响应头 (状态码, Cookie)
- 不出现 `binary data` ==> config/initializers
- `spec/acceptance`, `spec/requests` 都是 测试 controller

```bash
bin/rake docs:generate

# 打开
doc/api/index.html
```